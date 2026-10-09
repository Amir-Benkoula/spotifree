package com.amirbenkoula.spotiweb

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.media.AudioManager
import android.net.Uri
import android.os.Build
import androidx.core.content.FileProvider
import com.ryanheise.audioservice.AudioServiceActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

// AudioServiceActivity shares its FlutterEngine with the playback service.
class MainActivity : AudioServiceActivity() {
    private var channel: MethodChannel? = null

    // Headphones unplugged / Bluetooth audio lost: the page doesn't pause by itself.
    private val noisyReceiver =
        object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                if (intent.action == AudioManager.ACTION_AUDIO_BECOMING_NOISY) {
                    channel?.invokeMethod("becomingNoisy", null)
                }
            }
        }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // The engine outlives activities (audio_service caches it): its view
        // factory can only be registered once.
        if (player?.engine !== flutterEngine) {
            val playerChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "spotiweb/player")
            player =
                GeckoPlayer(applicationContext, playerChannel, flutterEngine).also {
                    flutterEngine.platformViewsController.registry.registerViewFactory(GeckoPlayer.VIEW_TYPE, it)
                }
        }

        channel =
            MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "spotiweb/system").apply {
                setMethodCallHandler { call, result ->
                    when (call.method) {
                        "moveTaskToBack" -> result.success(moveTaskToBack(true))
                        // Updates (lib/src/updater.dart): downloaded in the cache, then
                        // handed to the system installer, which asks to confirm.
                        "updatesDir" -> result.success(File(cacheDir, "updates").apply { mkdirs() }.absolutePath)
                        "installApk" ->
                            try {
                                val apk = File(call.arguments as String)
                                val uri = FileProvider.getUriForFile(this@MainActivity, "$packageName.updates", apk)
                                startActivity(
                                    Intent(Intent.ACTION_VIEW)
                                        .setDataAndType(uri, "application/vnd.android.package-archive")
                                        .addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_ACTIVITY_NEW_TASK),
                                )
                                result.success(null)
                            } catch (e: Exception) {
                                result.error("install", e.message, null)
                            }
                        "openUrl" ->
                            try {
                                startActivity(
                                    Intent(Intent.ACTION_VIEW, Uri.parse(call.arguments as String))
                                        .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK),
                                )
                                result.success(null)
                            } catch (e: Exception) {
                                result.error("open", e.message, null)
                            }
                        else -> result.notImplemented()
                    }
                }
            }

        val filter = IntentFilter(AudioManager.ACTION_AUDIO_BECOMING_NOISY)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            registerReceiver(noisyReceiver, filter, Context.RECEIVER_NOT_EXPORTED)
        } else {
            registerReceiver(noisyReceiver, filter)
        }
    }

    override fun onDestroy() {
        unregisterReceiver(noisyReceiver)
        channel?.setMethodCallHandler(null)
        super.onDestroy()
    }

    companion object {
        private var player: GeckoPlayer? = null
    }
}
