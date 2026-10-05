import 'package:flutter/material.dart';

import 'app_actions.dart';
import 'tiles.dart';
import 'web_bridge.dart';
import 'web_data.dart';

/// Pages the app shows on its own screens.
const appPageKinds = {
  'playlist',
  'album',
  'artist',
  'show',
  'episode',
  'track',
  'genre',
  'section',
  'user',
  'collection',
  'audiobook',
  'chapter',
  'concert',
  'search',
};

/// Shows one of the page's context menus as a sheet: the page opens it, the
/// sheet lists its entries, and an entry picked here is picked in the page.
Future<void> showWebMenu(
  BuildContext context,
  AppActions app,
  MenuTarget target, {
  String? path,
  MenuHeader? header,
}) async {
  final outcome = await showModalBottomSheet<MenuOutcome>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    showDragHandle: true,
    backgroundColor: const Color(0xFF242424),
    builder: (context) => _MenuSheet(app: app, target: target, path: path, header: header),
  );
  if (outcome == null) {
    // Closed without a pick: the page's menu closes too.
    app.content.closeMenu();
    return;
  }
  final navigated = outcome.navigated;
  if (navigated.isNotEmpty) {
    if (appPageKinds.contains(kindOfPath(navigated))) {
      app.openPath(navigated);
    } else {
      app.openWeb();
    }
  }
  if (outcome.dialog.isNotEmpty) {
    // Filled in on the page itself.
    app.openWeb();
    app.notify('« ${outcome.dialog} » : à compléter sur la page web');
  } else if (outcome.message.isNotEmpty) {
    app.notify(outcome.message);
  }
}

/// The icon of a menu entry, from its words (the page's menus have none the
/// app can read).
IconData menuIcon(String label) {
  final text = label.toLowerCase();
  bool has(List<String> words) => words.any(text.contains);
  if (has(['supprimer', 'retirer', 'remove', 'delete', 'quitter', 'leave'])) return Icons.remove_circle_outline_rounded;
  if (has(['ne plus suivre', 'unfollow', 'se désabonner'])) return Icons.person_remove_outlined;
  if (has(['nouvelle playlist', 'new playlist', 'créer', 'create'])) return Icons.add_rounded;
  if (has(['playlist'])) return Icons.playlist_add_rounded;
  if (has(["file d'attente", 'queue'])) return Icons.queue_music_rounded;
  if (has(['liké', 'liked', 'favori'])) return Icons.favorite_border_rounded;
  if (has(['radio'])) return Icons.radio_rounded;
  if (has(['artiste', 'artist'])) return Icons.person_outline_rounded;
  if (has(['album'])) return Icons.album_outlined;
  if (has(['crédit', 'credit'])) return Icons.info_outline_rounded;
  if (has(['copier', 'copy', 'lien', 'link'])) return Icons.link_rounded;
  if (has(['intégrer', 'embed'])) return Icons.code_rounded;
  if (has(['partager', 'share'])) return Icons.ios_share_rounded;
  if (has(['bibliothèque', 'library'])) return Icons.library_add_outlined;
  if (has(['télécharg', 'download'])) return Icons.download_rounded;
  if (has(['modifier', 'edit', 'renommer', 'rename'])) return Icons.edit_outlined;
  if (has(['épingl', 'pin'])) return Icons.push_pin_outlined;
  if (has(['dossier', 'folder'])) return Icons.folder_outlined;
  if (has(['suivre', 'follow', "s'abonner", 'abonner'])) return Icons.person_add_alt_outlined;
  if (has(['signaler', 'report'])) return Icons.flag_outlined;
  if (has(['exclure', 'exclude', 'masquer', 'hide'])) return Icons.visibility_off_outlined;
  if (has(['profil', 'profile'])) return Icons.account_circle_outlined;
  if (has(['privé', 'private', 'public', 'collaborati'])) return Icons.lock_outline_rounded;
  if (has(['ouvrir', 'open', 'accéder', 'go to'])) return Icons.open_in_new_rounded;
  return Icons.more_horiz_rounded;
}

class _MenuSheet extends StatefulWidget {
  const _MenuSheet({required this.app, required this.target, required this.path, required this.header});

  final AppActions app;
  final MenuTarget target;
  final String? path;
  final MenuHeader? header;

  @override
  State<_MenuSheet> createState() => _MenuSheetState();
}

class _MenuSheetState extends State<_MenuSheet> {
  /// The menu, then the submenus opened from it.
  final _menus = <WebMenu>[];
  Object? _error;
  bool _busy = true;
  String _filter = '';

  @override
  void initState() {
    super.initState();
    _open();
  }

  Future<void> _open() async {
    try {
      final menu = await widget.app.content.openMenu(widget.target, path: widget.path);
      if (!mounted) return;
      setState(() {
        _menus.add(menu);
        _busy = false;
      });
    } catch (error) {
      if (mounted) {
        setState(() {
          _error = error;
          _busy = false;
        });
      }
    }
  }

  Future<void> _pick(WebMenu menu, int index) async {
    setState(() => _busy = true);
    try {
      final result = await widget.app.content.pickMenu(menu, index);
      if (!mounted) return;
      if (result is WebMenu) {
        setState(() {
          _menus.add(result);
          _filter = '';
          _busy = false;
        });
      } else {
        Navigator.of(context).pop(result as MenuOutcome);
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _error = error;
          _busy = false;
        });
      }
    }
  }

  void _openWeb() {
    Navigator.of(context).pop();
    widget.app.openWeb(path: widget.path);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final menu = _menus.isEmpty ? null : _menus.last;
    final header = widget.header;
    final entries = menu?.entries ?? const <MenuEntry>[];
    final filter = _filter.toLowerCase();
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.85),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_menus.length > 1)
              ListTile(
                leading: const Icon(Icons.arrow_back_rounded),
                title: const Text('Retour'),
                onTap: _busy
                    ? null
                    : () => setState(() {
                        _menus.removeLast();
                        _filter = '';
                      }),
              )
            else if (header != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Row(
                  children: [
                    if (header.image.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Cover(url: header.image, size: 48, round: header.round),
                      ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            header.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          if (header.subtitle.isNotEmpty)
                            Text(
                              header.subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodySmall?.copyWith(color: Colors.white60),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            const Divider(height: 1),
            if (_busy) const LinearProgressIndicator(minHeight: 2) else const SizedBox(height: 2),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Text(
                      _error is WebError ? (_error as WebError).message : '$_error',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(onPressed: _openWeb, child: const Text('Voir la page web')),
                  ],
                ),
              )
            else if (menu != null) ...[
              if (entries.length > 10)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                  child: TextField(
                    onChanged: (text) => setState(() => _filter = text),
                    decoration: const InputDecoration(
                      isDense: true,
                      prefixIcon: Icon(Icons.search_rounded),
                      hintText: 'Rechercher',
                    ),
                  ),
                ),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    for (final (index, entry) in entries.indexed)
                      if (filter.isEmpty || entry.label.toLowerCase().contains(filter)) ...[
                        if (entry.separated && filter.isEmpty) const Divider(height: 8),
                        ListTile(
                          enabled: !entry.disabled && !_busy,
                          leading: Icon(menuIcon(entry.label)),
                          title: Text(entry.label),
                          trailing: entry.submenu
                              ? const Icon(Icons.chevron_right_rounded)
                              : entry.checked == true
                              ? const Icon(Icons.check_rounded)
                              : null,
                          onTap: () => _pick(menu, index),
                        ),
                      ],
                    if (widget.target is PageTarget && _menus.length == 1)
                      ListTile(
                        leading: const Icon(Icons.public_rounded),
                        title: const Text('Voir la page web'),
                        onTap: _busy ? null : _openWeb,
                      ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
