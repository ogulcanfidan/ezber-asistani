import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_state.dart';
import '../l10n/app_localizations.dart';
import '../data/doc_import.dart' show decodeText;
import '../data/pro.dart' show proUnlocked;
import 'pro_screen.dart';

/// Play Console'a verilen adresle aynı olmalı.
final privacyPolicyUrl = Uri.parse('https://fmjapps.github.io/privacy/ezber/');

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _backup(BuildContext context) async {
    final json = await AppScope.of(context).repository.exportAll();
    final dir = await getTemporaryDirectory();
    final stamp = DateTime.now().toIso8601String().substring(0, 10);
    final file = File('${dir.path}${Platform.pathSeparator}ezber-backup-$stamp.json');
    await file.writeAsString(json);
    await SharePlus.instance.share(ShareParams(files: [XFile(file.path, mimeType: 'application/json')]));
  }

  Future<void> _restore(BuildContext context) async {
    final l = L.of(context);
    final repo = AppScope.of(context).repository;
    final messenger = ScaffoldMessenger.of(context);
    final files = await FilePicker.pickFiles(type: FileType.custom, allowedExtensions: ['json']);
    if (files.isEmpty) return;
    try {
      final count = await repo.importAll(decodeText(await files.first.readAsBytes()));
      messenger.showSnackBar(SnackBar(content: Text(l.restoreDone(count))));
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(l.restoreFailed)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = L.of(context);
    final state = AppScope.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.settings)),
      body: ListView(
        children: [
          if (!proUnlocked) ...[
          ValueListenableBuilder<bool>(
            valueListenable: state.pro.isPro,
            builder: (context, isPro, _) => ListTile(
              leading: const Icon(Icons.workspace_premium_outlined),
              title: Text(l.proTitle),
              subtitle: Text(isPro ? l.proActive : l.proUpgrade),
              trailing: isPro ? const Icon(Icons.check_circle_outline) : const Icon(Icons.chevron_right),
              onTap: () => isPro
                  ? launchUrl(manageSubscriptionUrl, mode: LaunchMode.externalApplication)
                  : showProScreen(context),
            ),
          ),
          const Divider(),
          ],
          ValueListenableBuilder<Locale?>(
            valueListenable: state.locale,
            builder: (context, locale, _) => ListTile(
              leading: const Icon(Icons.language),
              title: Text(l.appLanguage),
              subtitle: Text(locale == null ? l.systemDefault : supportedLanguages[locale.languageCode]!),
              onTap: () => showDialog<void>(
                context: context,
                builder: (context) => SimpleDialog(
                  title: Text(l.appLanguage),
                  children: [
                    for (final entry in <String?, String>{null: l.systemDefault, ...supportedLanguages}.entries)
                      SimpleDialogOption(
                        onPressed: () {
                          state.setLocale(entry.key == null ? null : Locale(entry.key!));
                          Navigator.pop(context);
                        },
                        child: Text(entry.value),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.backup_outlined),
            title: Text(l.backup),
            subtitle: Text(l.backupHelp),
            onTap: () => _backup(context),
          ),
          ListTile(
            leading: const Icon(Icons.restore),
            title: Text(l.restore),
            onTap: () => _restore(context),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: Text(l.privacy),
            subtitle: Text(l.privacyText),
          ),
          ListTile(
            leading: const Icon(Icons.open_in_new),
            title: Text(l.privacyPolicyFull),
            onTap: () => launchUrl(privacyPolicyUrl, mode: LaunchMode.externalApplication),
          ),
          const Divider(),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snap) => ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text(l.appVersion),
              subtitle: Text(snap.hasData ? '${snap.data!.version} (${snap.data!.buildNumber})' : ''),
            ),
          ),
        ],
      ),
    );
  }
}
