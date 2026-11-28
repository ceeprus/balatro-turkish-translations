# Balatro TR çevirisinin hızlı kurulumu (macOS)

## Gereksinimler

Öncelikle şunları kontrol edin:

- **macOS** kullanıyorsunuz. (veya, [başka bir yöntem](INSTALL.md))
- Balatro+ **Apple Arcade** ile yüklü (`/Applications/Balatro.app`).
- Balatro'yu **en az bir kez açıp kapattınız** (kayıt klasörü o zaman oluşur).

> [!NOTE]
> Betik Apple Arcade sürümü (1.0.1o) ile denendi. Steam'in Mac sürümü için de bir yol var ama **denenmedi**.

## Kurulum

- Repoyu indirin ([ZIP](https://github.com/ceeprus/balatro-turkish-translations/archive/refs/heads/main.zip)) ve klasörü açın.
- **Balatro'yu kapatın.**
- Terminal'i açın, klasöre gidin ve betiği çalıştırın:
  ```bash
  bash Balatro_TR_macOS.sh
  ```
  macOS "Terminal başka uygulamaların verilerine erişmek istiyor" diye sorarsa izin verin.
- Sprite'ları (kartlar, paketler vs.) çevirmek istediğinizi onaylamak için _E_ (veya _H_) yanıtını verin.
- **Balatro'yu her zamanki gibi açın** ve Ayarlar > Dil menüsünden Türkçe'yi seçin. Tebrikler, Balatro için Türkçe yamayı yüklediniz 🥳

## Betik ne yapar?

- `Balatro.app`'e **dokunmaz**; uygulamanın imzası bozulmaz, "hasar görmüş" uyarısı çıkmaz.
- LÖVE oyun motoru dosyaları önce oyunun kayıt klasöründen okur. Betik çeviri dosyalarını oraya kopyalar:
  `~/Library/Containers/com.playstack.balatroarcade/Data/Library/Application Support/game/`
- Oradaki `game.lua` küçük bir yükleyicidir. Oyunun kendi `game.lua`'sını okuyup dil listesine Türkçe'yi ve eksik metinler için İngilizce yedeği ekler. Bu yüzden oyun güncellendiğinde de çalışmaya devam etmesi beklenir.
- Kayıtlarınıza (iCloud dahil) dokunulmaz.

## Kaldırma

```bash
bash Balatro_TR_macOS.sh --kaldir
```

Yalnızca betiğin kopyaladığı dosyaları siler; kayıtlarınız yerinde kalır.

Çeviriyi beğendiyseniz paylaşmayı unutmayın! Teşekkürler 🤍

[↩ Proje ana sayfasına dön](https://github.com/ceeprus/balatro-turkish-translations)
