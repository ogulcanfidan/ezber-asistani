# Kapalı test sürümü: tüm Pro özellikleri açık (abonelik ekranı yok).
# Mağaza/abonelikli sürüm için: flutter build appbundle --release (bayraksız).
$env:Path = "C:\Users\FMJ\develop\flutter\bin;" + $env:Path
Set-Location (Split-Path $PSScriptRoot -Parent)
flutter build appbundle --release --dart-define=PRO_UNLOCKED=true
