import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_state.dart';
import '../data/pro.dart';
import '../l10n/app_localizations.dart';

/// Play'in abonelik yönetim sayfası (iptal, ödeme yöntemi).
final manageSubscriptionUrl = Uri.parse(
  'https://play.google.com/store/account/subscriptions?sku=$proProductId&package=com.fmjapps.ezberasistani',
);

/// Pro sayfasını açar; kullanıcı sonunda Pro ise true döner.
Future<bool> showProScreen(BuildContext context) async {
  final pro = AppScope.of(context).pro;
  if (pro.isPro.value) return true;
  await Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const ProScreen()));
  return pro.isPro.value;
}

class ProScreen extends StatefulWidget {
  const ProScreen({super.key});

  @override
  State<ProScreen> createState() => _ProScreenState();
}

class _ProScreenState extends State<ProScreen> {
  Future<ProOffer?>? _offer;
  bool _busy = false;
  late ProStore _pro;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_offer == null) {
      _pro = AppScope.of(context).pro;
      _offer = _pro.offer();
      _pro.isPro.addListener(_onPro);
    }
  }

  @override
  void dispose() {
    _pro.isPro.removeListener(_onPro);
    super.dispose();
  }

  /// Satın alma Play'in kendi penceresinde tamamlanır; sonuç akıştan gelir.
  void _onPro() {
    if (!mounted || !_pro.isPro.value) return;
    final messenger = ScaffoldMessenger.of(context);
    final l = L.of(context);
    Navigator.of(context).pop();
    messenger.showSnackBar(SnackBar(content: Text(l.proThanks)));
  }

  Future<void> _buy() async {
    final l = L.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);
    final result = await _pro.buy();
    if (!mounted) return;
    setState(() => _busy = false);
    if (result != ProBuyResult.started) {
      messenger.showSnackBar(SnackBar(content: Text(l.proUnavailable)));
    }
  }

  Future<void> _restore() async {
    final l = L.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);
    await _pro.restore();
    if (!mounted) return;
    setState(() => _busy = false);
    if (!_pro.isPro.value) messenger.showSnackBar(SnackBar(content: Text(l.proNotFound)));
  }

  @override
  Widget build(BuildContext context) {
    final l = L.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.proTitle)),
      body: SafeArea(
        child: FutureBuilder<ProOffer?>(
          future: _offer,
          builder: (context, snap) {
            final offer = snap.data;
            final loading = snap.connectionState != ConnectionState.done;
            final trial = offer?.trialDays;
            return ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Icon(Icons.workspace_premium_outlined, size: 64, color: theme.colorScheme.primary),
                const SizedBox(height: 12),
                Text(l.proPitch, style: theme.textTheme.titleLarge, textAlign: TextAlign.center),
                const SizedBox(height: 24),
                ListTile(
                  leading: const Icon(Icons.hearing_outlined),
                  title: Text(l.proFeatureHandsFree),
                ),
                ListTile(
                  leading: const Icon(Icons.all_inclusive),
                  title: Text(l.proFeatureUnlimited(freePieceLimit)),
                ),
                const SizedBox(height: 24),
                if (loading)
                  const Center(child: CircularProgressIndicator())
                else if (offer == null)
                  Text(l.proUnavailable, textAlign: TextAlign.center)
                else ...[
                  Text(
                    trial != null ? l.proTrial(trial, offer.monthlyPrice) : l.proPrice(offer.monthlyPrice),
                    style: theme.textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: _busy ? null : _buy,
                    child: Text(trial != null ? l.proStartTrial : l.proSubscribe),
                  ),
                ],
                const SizedBox(height: 8),
                TextButton(onPressed: _busy ? null : _restore, child: Text(l.proRestore)),
                const SizedBox(height: 16),
                Text(l.proTerms, style: theme.textTheme.bodySmall, textAlign: TextAlign.center),
                TextButton(
                  onPressed: () => launchUrl(manageSubscriptionUrl, mode: LaunchMode.externalApplication),
                  child: Text(l.proManage),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
