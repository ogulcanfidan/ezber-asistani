import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Play Console'daki abonelik kimliği (Para kazanma > Abonelikler).
const proProductId = 'ezber_pro';

/// Kapalı test sürümü: her şey açık, abonelik ekranı yok. Derlerken
/// `--dart-define=PRO_UNLOCKED=true` (bkz. tool/build_test_aab.ps1). Mağaza
/// (abonelikli) sürümü bu bayrak olmadan derlenir.
const proUnlocked = bool.fromEnvironment('PRO_UNLOCKED');

/// Ücretsiz sürümde kaydedilebilecek metin sayısı.
const freePieceLimit = 3;

/// Abonelik sayfasında gösterilecek teklif.
class ProOffer {
  const ProOffer({required this.monthlyPrice, this.trialDays});

  /// Yerel para biriminde biçimlenmiş aylık fiyat ("₺28,99").
  final String monthlyPrice;

  /// Ücretsiz deneme süresi (gün); deneme yoksa veya kullanılmışsa null.
  final int? trialDays;
}

enum ProBuyResult { started, unavailable, failed }

/// Pro (aylık abonelik) durumu. Doğrulama sunucusu yok: Google Play'in
/// cihaza bildirdiği etkin abonelik esas alınır; son bilinen durum çevrimdışı
/// açılış için saklanır.
abstract class ProStore {
  ValueListenable<bool> get isPro;

  /// Mağazadan fiyat/deneme bilgisi; abonelik tanımlı değilse null.
  Future<ProOffer?> offer();

  Future<ProBuyResult> buy();

  /// Etkin aboneliği Google Play'den yeniden sorgular.
  Future<void> restore();
}

class PlayProStore implements ProStore {
  PlayProStore(this._prefs) : _isPro = ValueNotifier(_prefs.getBool(_key) ?? false);

  static const _key = 'pro';
  final SharedPreferences _prefs;
  final ValueNotifier<bool> _isPro;
  final _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _sub;
  List<GooglePlayProductDetails>? _products;

  @override
  ValueListenable<bool> get isPro => _isPro;

  void _set(bool value) {
    if (_isPro.value == value) return;
    _isPro.value = value;
    _prefs.setBool(_key, value);
  }

  /// Satın alma akışını dinlemeye başlar ve mevcut aboneliği sorgular.
  Future<void> init() async {
    _sub ??= _iap.purchaseStream.listen(_onPurchases, onError: (Object e) {
      if (kDebugMode) debugPrint('Satın alma akışı hatası: $e');
    });
    await restore();
  }

  Future<void> _onPurchases(List<PurchaseDetails> purchases) async {
    for (final p in purchases) {
      if (p.productID != proProductId) continue;
      if (p.status == PurchaseStatus.purchased || p.status == PurchaseStatus.restored) {
        _set(true);
      }
      // Onaylanmayan (acknowledge) abonelik 3 gün içinde iade edilir.
      if (p.pendingCompletePurchase) await _iap.completePurchase(p);
    }
  }

  @override
  Future<void> restore() async {
    try {
      if (!await _iap.isAvailable()) return;
      final addition = _iap.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
      final response = await addition.queryPastPurchases();
      if (response.error != null) return; // Bilinmiyor: son durum korunur.
      final active = response.pastPurchases.where((p) => p.productID == proProductId).toList();
      for (final p in active) {
        if (p.pendingCompletePurchase) await _iap.completePurchase(p);
      }
      // Süresi dolan/iptal edilen abonelik listede görünmez.
      _set(active.isNotEmpty);
    } catch (e) {
      if (kDebugMode) debugPrint('Abonelik sorgulanamadı: $e');
    }
  }

  Future<List<GooglePlayProductDetails>> _load() async {
    final cached = _products;
    if (cached != null && cached.isNotEmpty) return cached;
    if (!await _iap.isAvailable()) return const [];
    final response = await _iap.queryProductDetails({proProductId});
    return _products = response.productDetails.whereType<GooglePlayProductDetails>().toList();
  }

  /// Deneme teklifi varsa (ve kullanıcı daha önce kullanmadıysa Play onu
  /// döndürür) o, yoksa temel plan.
  GooglePlayProductDetails? _best(List<GooglePlayProductDetails> list) {
    GooglePlayProductDetails? base;
    for (final d in list) {
      final offer = d.productDetails.subscriptionOfferDetails?[d.subscriptionIndex!];
      if (offer == null) continue;
      if (offer.offerId == null) {
        base ??= d;
      } else if (offer.pricingPhases.first.priceAmountMicros == 0) {
        return d;
      }
    }
    return base ?? (list.isEmpty ? null : list.first);
  }

  @override
  Future<ProOffer?> offer() async {
    try {
      final best = _best(await _load());
      if (best == null) return null;
      final phases = best.productDetails.subscriptionOfferDetails![best.subscriptionIndex!].pricingPhases;
      final trial = phases.first.priceAmountMicros == 0 ? phases.first : null;
      return ProOffer(
        monthlyPrice: phases.last.formattedPrice,
        trialDays: trial == null ? null : isoDays(trial.billingPeriod),
      );
    } catch (e) {
      if (kDebugMode) debugPrint('Abonelik bilgisi alınamadı: $e');
      return null;
    }
  }

  @override
  Future<ProBuyResult> buy() async {
    try {
      final best = _best(await _load());
      if (best == null) return ProBuyResult.unavailable;
      final ok = await _iap.buyNonConsumable(purchaseParam: GooglePlayPurchaseParam(productDetails: best));
      return ok ? ProBuyResult.started : ProBuyResult.failed;
    } catch (e) {
      if (kDebugMode) debugPrint('Satın alma başlatılamadı: $e');
      return ProBuyResult.failed;
    }
  }
}

/// ISO-8601 süresini ("P3D", "P1W") güne çevirir.
int? isoDays(String period) {
  final m = RegExp(r'^P(?:(\d+)W)?(?:(\d+)D)?$').firstMatch(period);
  if (m == null) return null;
  final days = int.parse(m.group(1) ?? '0') * 7 + int.parse(m.group(2) ?? '0');
  return days == 0 ? null : days;
}

/// Test sürümünde: her zaman Pro, Play'e hiç sorulmaz.
class UnlockedProStore implements ProStore {
  final _isPro = ValueNotifier(true);

  @override
  ValueListenable<bool> get isPro => _isPro;

  @override
  Future<ProOffer?> offer() async => null;

  @override
  Future<ProBuyResult> buy() async => ProBuyResult.started;

  @override
  Future<void> restore() async {}
}

/// Testler ve Play Billing olmayan ortamlar için.
class FakeProStore implements ProStore {
  FakeProStore({bool pro = false, this.available = true}) : _isPro = ValueNotifier(pro);

  final ValueNotifier<bool> _isPro;
  bool available;
  int buys = 0;

  @override
  ValueListenable<bool> get isPro => _isPro;

  set pro(bool v) => _isPro.value = v;

  @override
  Future<ProOffer?> offer() async => available ? const ProOffer(monthlyPrice: '₺28,99', trialDays: 3) : null;

  @override
  Future<ProBuyResult> buy() async {
    buys++;
    if (!available) return ProBuyResult.unavailable;
    _isPro.value = true;
    return ProBuyResult.started;
  }

  @override
  Future<void> restore() async {}
}
