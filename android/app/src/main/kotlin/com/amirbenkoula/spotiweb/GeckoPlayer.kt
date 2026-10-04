package com.amirbenkoula.spotiweb

import android.content.Context
import android.content.Intent
import android.content.pm.ApplicationInfo
import android.graphics.Color
import android.net.Uri
import android.util.Log
import android.view.View
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import org.json.JSONObject
import org.mozilla.geckoview.AllowOrDeny
import org.mozilla.geckoview.GeckoResult
import org.mozilla.geckoview.GeckoRuntime
import org.mozilla.geckoview.GeckoRuntimeSettings
import org.mozilla.geckoview.GeckoSession
import org.mozilla.geckoview.GeckoSession.PermissionDelegate.ContentPermission
import org.mozilla.geckoview.GeckoSessionSettings
import org.mozilla.geckoview.GeckoView
import org.mozilla.geckoview.WebExtension
import org.mozilla.geckoview.WebRequestError

/**
 * open.spotify.com rendered by GeckoView, Firefox's engine.
 *
 * Android WebView stamps every request with `X-Requested-With: <package>` and
 * Spotify then silently refuses to play; GeckoView sends no such header, and
 * Firefox desktop is a browser Spotify supports.
 *
 * The page script and stylesheet (Flutter assets in assets/inject/) are loaded by
 * a built-in WebExtension. Its relay content script talks to this class through
 * GeckoView native messaging; this class talks to Dart through [channel].
 */
class GeckoPlayer(
    private val context: Context,
    private val channel: MethodChannel,
    val engine: FlutterEngine,
) : PlatformViewFactory(StandardMessageCodec.INSTANCE), MethodChannel.MethodCallHandler {
    private var view: GeckoView? = null
    private var session: GeckoSession? = null
    private var extension: WebExtension? = null
    private var port: WebExtension.Port? = null
    private var canGoBack = false
    private var injectionDisabled = false

    init {
        channel.setMethodCallHandler(this)
    }

    // ------------------------------------------------------------ platform view
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        injectionDisabled = (args as? Map<*, *>)?.get("noInject") == true
        val view = GeckoView(context).apply { coverUntilFirstPaint(Color.BLACK) }
        this.view = view
        start(view)
        return object : PlatformView {
            override fun getView(): View = view

            override fun dispose() {
                session?.let {
                    view.releaseSession()
                    it.close()
                }
                session = null
                this@GeckoPlayer.view = null
            }
        }
    }

    private fun start(view: GeckoView) {
        val session = newSession().also { it.open(runtime(context)) }
        view.setSession(session)
        this.session = session
        if (injectionDisabled) {
            session.loadUri(PLAYER_URL)
            return
        }
        // The message delegate must be in place before the page (and its relay) loads.
        val install = extension?.let { GeckoResult.fromValue(it) }
            ?: runtime(context).webExtensionController.installBuiltIn(EXTENSION_URI)
        install.accept(
            { installed ->
                extension = installed
                if (installed != null) {
                    session.webExtensionController.setMessageDelegate(installed, messages, NATIVE_APP)
                }
                session.loadUri(PLAYER_URL)
            },
            { error ->
                Log.e(TAG, "Page extension failed to install", error)
                session.loadUri(PLAYER_URL)
            },
        )
    }

    private fun newSession(): GeckoSession {
        val settings =
            GeckoSessionSettings.Builder()
                .userAgentOverride(desktopUserAgent())
                // Keep the phone viewport: mobile.css lays the page out for it.
                .viewportMode(GeckoSessionSettings.VIEWPORT_MODE_MOBILE)
                .build()
        return GeckoSession(settings).apply {
            permissionDelegate = permissions
            navigationDelegate = navigation
            progressDelegate = progress
            contentDelegate = content
        }
    }

    // ---------------------------------------------------------------- delegates
    private val messages =
        object : WebExtension.MessageDelegate {
            override fun onConnect(port: WebExtension.Port) {
                this@GeckoPlayer.port = port
                port.setDelegate(
                    object : WebExtension.PortDelegate {
                        override fun onPortMessage(message: Any, port: WebExtension.Port) {
                            channel.invokeMethod("message", message.toString())
                        }

                        override fun onDisconnect(port: WebExtension.Port) {
                            if (this@GeckoPlayer.port === port) this@GeckoPlayer.port = null
                        }
                    },
                )
            }
        }

    // Spotify streams are Widevine protected, and playback is started from native
    // controls (notification, headset) without a gesture in the page.
    private val permissions =
        object : GeckoSession.PermissionDelegate {
            override fun onContentPermissionRequest(
                session: GeckoSession,
                perm: ContentPermission,
            ): GeckoResult<Int> {
                val allowed =
                    when (perm.permission) {
                        GeckoSession.PermissionDelegate.PERMISSION_MEDIA_KEY_SYSTEM_ACCESS,
                        GeckoSession.PermissionDelegate.PERMISSION_AUTOPLAY_AUDIBLE,
                        GeckoSession.PermissionDelegate.PERMISSION_AUTOPLAY_INAUDIBLE,
                        -> true
                        else -> false
                    }
                return GeckoResult.fromValue(if (allowed) ContentPermission.VALUE_ALLOW else ContentPermission.VALUE_DENY)
            }
        }

    private val navigation =
        object : GeckoSession.NavigationDelegate {
            override fun onLocationChange(
                session: GeckoSession,
                url: String?,
                perms: List<ContentPermission>,
                hasUserGesture: Boolean,
            ) {
                if (url != null) channel.invokeMethod("location", url)
            }

            override fun onCanGoBack(session: GeckoSession, canGoBack: Boolean) {
                this@GeckoPlayer.canGoBack = canGoBack
            }

            override fun onLoadRequest(
                session: GeckoSession,
                request: GeckoSession.NavigationDelegate.LoadRequest,
            ): GeckoResult<AllowOrDeny> {
                val uri = Uri.parse(request.uri)
                return when {
                    uri.scheme == "about" || uri.scheme == "data" || uri.scheme == "blob" -> GeckoResult.allow()
                    // spotify:, intent: … would try to open the official app.
                    uri.scheme != "http" && uri.scheme != "https" -> GeckoResult.deny()
                    staysInApp(uri) -> GeckoResult.allow()
                    else -> {
                        openExternally(uri)
                        GeckoResult.deny()
                    }
                }
            }

            // Popups (window.open, target=_blank) open in place or outside the app.
            override fun onNewSession(session: GeckoSession, uri: String): GeckoResult<GeckoSession>? {
                val parsed = Uri.parse(uri)
                if (staysInApp(parsed)) session.loadUri(uri) else openExternally(parsed)
                return null
            }

            override fun onLoadError(
                session: GeckoSession,
                uri: String?,
                error: WebRequestError,
            ): GeckoResult<String>? {
                val reason = if (error.category == WebRequestError.ERROR_CATEGORY_NETWORK) "réseau" else "${error.code}"
                channel.invokeMethod("loadError", "Erreur de chargement ($reason)")
                return null
            }
        }

    private val progress =
        object : GeckoSession.ProgressDelegate {
            override fun onPageStart(session: GeckoSession, url: String) {
                channel.invokeMethod("pageStart", url)
            }
        }

    // The content process can be killed (memory pressure in background): start over.
    private val content =
        object : GeckoSession.ContentDelegate {
            override fun onCrash(session: GeckoSession) = restart(session)

            override fun onKill(session: GeckoSession) = restart(session)
        }

    private fun restart(dead: GeckoSession) {
        val view = view ?: return
        if (dead !== session) return
        view.releaseSession()
        dead.close()
        port = null
        start(view)
    }

    // --------------------------------------------------------------- dart calls
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "command" -> {
                val port = port
                if (port == null) {
                    result.success(false)
                    return
                }
                val message = JSONObject().put("name", call.argument<String>("name"))
                call.argument<Any>("arg")?.let { message.put("arg", JSONObject.wrap(it)) }
                port.postMessage(message)
                result.success(true)
            }
            "goBack" -> {
                val session = session
                if (session != null && canGoBack) {
                    session.goBack()
                    result.success(true)
                } else {
                    result.success(false)
                }
            }
            "reload" -> {
                session?.reload()
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }

    private fun openExternally(uri: Uri) {
        try {
            context.startActivity(Intent(Intent.ACTION_VIEW, uri).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK))
        } catch (e: Exception) {
            Log.w(TAG, "No app to open $uri", e)
        }
    }

    companion object {
        const val VIEW_TYPE = "spotiweb/gecko"
        private const val TAG = "SpotiWeb"
        private const val PLAYER_URL = "https://open.spotify.com/"

        // Flutter bundles assets/inject/ (manifest.json included) in the APK assets.
        private const val EXTENSION_URI = "resource://android/assets/flutter_assets/assets/inject/"

        // Must match the name used by relay.js in runtime.connectNative().
        private const val NATIVE_APP = "spotiweb"

        private var runtime: GeckoRuntime? = null

        /** One Gecko runtime per process. */
        fun runtime(context: Context): GeckoRuntime =
            runtime ?: run {
                val debuggable = (context.applicationInfo.flags and ApplicationInfo.FLAG_DEBUGGABLE) != 0
                val settings =
                    GeckoRuntimeSettings.Builder()
                        // Debug builds: page console in logcat, and remote debugging
                        // from desktop Firefox (about:debugging).
                        .consoleOutput(debuggable)
                        .remoteDebuggingEnabled(debuggable)
                        .build()
                GeckoRuntime.create(context.applicationContext, settings).also { runtime = it }
            }

        /** Hosts allowed to load inside the app: the player and the login flows. */
        private fun staysInApp(uri: Uri): Boolean {
            val host = uri.host ?: return false
            fun under(domain: String) = host == domain || host.endsWith(".$domain")
            return under("spotify.com") ||
                under("spotifycdn.com") ||
                under("scdn.co") ||
                under("accounts.google.com") ||
                under("facebook.com") ||
                under("appleid.apple.com")
        }

        /**
         * Firefox desktop on Linux, same version as the engine: the server sends the
         * full web player, instead of the mobile site, based on the User-Agent.
         */
        private fun desktopUserAgent(): String {
            val version = Regex("""rv:([\d.]+)""").find(GeckoSession.getDefaultUserAgent())?.groupValues?.get(1) ?: "157.0"
            return "Mozilla/5.0 (X11; Linux x86_64; rv:$version) Gecko/20100101 Firefox/$version"
        }
    }
}
