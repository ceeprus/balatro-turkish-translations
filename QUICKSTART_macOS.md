# Balatro TR çevirisinin hızlı kurulumu (macOS)

## Gereksinimler

Öncelikle şunları kontrol edin:

- **macOS** kullanıyorsunuz. (veya, [başka bir yöntem](INSTALL.md))
- Balatro+ **Apple Arcade** ile yüklü (`/Applications/Balatro.app`).
- Balatro oyununuz **güncel**.

> [!NOTE]
> Betik Apple Arcade sürümü (1.0.1o) ile denendi. Steam'in Mac sürümü için de bir yol var ama **denenmedi**.

## Kurulum

- Repoyu indirin ([ZIP](https://github.com/ceeprus/balatro-turkish-translations/archive/refs/heads/main.zip)) ve klasörü açın.
- **Balatro'yu kapatın.**
- Terminal'i açın, klasöre gidin ve betiği çalıştırın:
  ```bash
  bash Balatro_TR_macOS.sh
  ```
- Sprite'ları (kartlar, paketler vs.) çevirmek istediğinizi onaylamak için _E_ (veya _H_) yanıtını verin.
- Oyunu **`~/Applications/Balatro Türkçe.app`** ile açın ve Ayarlar > Dil menüsünden Türkçe'yi seçin. Tebrikler, Balatro için Türkçe yamayı yüklediniz 🥳

## Betik ne yapar?

- Orijinal `/Applications/Balatro.app`'e **dokunmaz**. Türkçe kopyayı `~/Applications/Balatro TR.app` olarak kurar.
- Oyun sürümü `localization_files_macOS/VERSION` ile aynıysa hazır `game.lua`'yı kullanır. Farklıysa oyunun kendi `game.lua`'sına yalnızca Türkçe dil satırını ve İngilizce yedekli yüklemeyi ekler. Çevirisi olmayan metinler İngilizce görünür.
- Kopyanın Apple imzası bozulduğu için macOS onu doğrudan açmaz. `Balatro Türkçe.app` başlatıcısı oyunu bir Terminal penceresi üzerinden açar; pencereyi kapatabilirsiniz, oyun kapanmaz.
- Kayıtlar iCloud üzerinden orijinal oyunla ortak kalır.

> [!CAUTION]
> `Balatro TR.app`'e doğrudan çift tıklarsanız macOS "hasar görmüş" der. **Çöp Sepeti'ne Taşı'ya basmayın**; pencereyi kapatıp başlatıcıyı kullanın.

> [!NOTE]
> Oyun güncellendiğinde betiği yeniden çalıştırın. Kopyayı kaldırmak için `~/Applications/Balatro TR.app` ve `~/Applications/Balatro Türkçe.app`'i silmeniz yeterli.

Çeviriyi beğendiyseniz paylaşmayı unutmayın! Teşekkürler 🤍

[↩ Proje ana sayfasına dön](https://github.com/ceeprus/balatro-turkish-translations)
