# Kurulum Yöntemleri

Balatro'nun Türkçe çevirisini kullanmanın birçok yolu vardır; size en uygun olanı seçin.

## Hiçbir şey bilmiyorum (ve Windows kullanıyorum)

Buraya bak 👉 [**Balatro'nun TR çevirisini yüklemek için buraya tıklayın Windows**](QUICKSTART.md).

### Balatro.exe üzerinde 7zip kullanarak (Manuel kurulum)

1. [7zip](https://7-zip.org/) indirin. Hayır, WinRAR çalışmıyor.
2. **Balatro'yu kapatın.**
3. Arşivi indirin [Balatro_TR_Manual_Install.zip](https://github.com/ceeprus/balatro-turkish-translations/releases/latest/download/Balatro_TR_Manual_Install.zip)
4. Balatro'nun yüklü olduğu klasöre gidin. (Örn.: `SteamLibrary\steamapps\common\Balatro\`). <br/> Balatro'nun nerede olduğunu bilmiyorsanız, Steam kütüphanenizdeki Balatro'ya sağ tıklayıp _Yönet_ ve ardından _Yerel dosyalara gözat_ seçeneğine tıklayabilirsiniz.
5. Balatro.exe`ye sağ tıklayın, ardından _7-Zip_ menüsünde _Arşivi aç_ seçeneğine tıklayın.
6. 7zip içinde `localization` klasörünü açın.
7. Adım 3'te indirdiğiniz arşivdeki `localization` klasöründen `tr.lua` dosyasını sürükleyip bırakın ve dosyanın kopyasını onaylayın.
8. `game.lua`yı orjinal dosyası ile değiştirin.
9. Aynı şekilde `resources/textures` klasöründeki oyun görsellerini de 3. adımda indirdiğiniz arşivin `localization/assets` klasöründekilerle değiştirin. **Yalnızca arşivimizdeki mevcut resimleri değiştirin ve diğerlerini silmeyin.**
10. **Oyunu başlatın** Henüz yapmadıysanız, sağ alttaki düğmeyi kullanarak Türkçe dilini seçin. Tebrikler, Balatro'yu Türkçe'ye çevirdin 🥳

### macOS Kurulum (Apple Arcade / Balatro+)

> [!NOTE]
> Apple Arcade sürümü (1.0.1o) ile denendi. Steam'in Mac sürümü için de betikte bir yol var ama **denenmedi**.

1. **Balatro'yu kapatın.**
2. Bu repoyu indirin ([ZIP](https://github.com/ceeprus/balatro-turkish-translations/archive/refs/heads/main.zip)) ve klasörü açın.
3. Terminal'de klasöre gidip betiği çalıştırın: `bash Balatro_TR_macOS.sh`
4. Betik orijinal `/Applications/Balatro.app`'e dokunmaz. Türkçe kopyayı `~/Applications/Balatro TR.app` olarak, başlatıcıyı da `~/Applications/Balatro Türkçe.app` olarak kurar.
5. Oyunu **her zaman `Balatro Türkçe.app` ile açın.** Başlatıcı oyunu bir Terminal penceresi üzerinden açar.
6. Ayarlar > Dil menüsünden Türkçe'yi seçin. Tebrikler, Balatro'yu Türkçe'ye çevirdin 🥳

> [!WARNING]
> Yamalı kopyanın Apple imzası bozulur. `Balatro TR.app`'e doğrudan çift tıklarsanız macOS "hasar görmüş" der; **Çöp Sepeti'ne Taşı'ya basmayın**, pencereyi kapatıp başlatıcıyı kullanın.

Neden kopya? Apple Arcade sürümünün `game.lua` dosyası Steam'inkinden farklıdır; repodaki `game.lua` ile değiştirmek oyunu bozar. Betik yalnızca dil listesine Türkçe satırını ekler ve eksik metinler için İngilizce yedek yükler. Kayıtlar iCloud üzerinden orijinal oyunla ortak kalır.

### Gamepass Kurulum

1. **Balatro'yu kapatın.**
2. XBOX uygulamasını açın.
3. Arşivi indirin [Balatro_TR_Manual_Install_XBOX.zip](https://github.com/ceeprus/balatro-turkish-translations/releases/latest/download/Balatro_TR_Manual_Install_XBOX.zip)
4. Balatro'nun yüklü olduğu klasöre gidin. (Örn.: `XboxGames\Balatro\Content\`). <br/> Balatro'nun nerede olduğunu bilmiyorsanız, XBOX Uygulamasından Balatro simgesine sağ tıkladıktan sonra sırasıyla: _Yönet_ > _Dosyalar_ > _Gözat _ seçeneğine tıklayın.
5. Adım 3'te indirdiğiniz arşivdeki `Assets` dosyasını sürükleyip bırakın ve dosyanın kopyasını onaylayın.
6. **Oyunu başlatın** Henüz yapmadıysanız, sağ alttaki düğmeyi kullanarak Türkçe dilini seçin. Tebrikler, Balatro'yu Türkçe'ye çevirdin 🥳

### Nintendo Switch Kurulum
> [!IMPORTANT]
> Nintendo Switch kurulumu için Atmosphère donanım yazılımı kurulu olmalıdır. [Yazılımı kurmak için bu adımları izleyebilirsiniz.](https://switch.hacks.guide)

1. SD kartınızın kök dizinine girin ve `atmosphere/contents/` klasörüne erişin.
2. `0100CD801CE5E000` adlı bir klasör oluşturun ve bu klasör içinde `romfs` içinde bir klasör daha oluşturun.
3. `localization_switch` klasörünün içindeki dosyaları oluşturduğunuz klasöre kopyalayın ve sisteminizi yeniden başlatın.
4. **Oyunu başlatın** Henüz yapmadıysanız, sağ alttaki düğmeyi kullanarak Türkçe dilini seçin. Tebrikler, Balatro'yu Türkçe'ye çevirdin 🥳

> [!IMPORTANT]
> Oyun her güncellendiğinde dosyalar da güncellenmelidir.

[↩ Proje ana sayfasına dönün](https://github.com/ceeprus/balatro-turkish-translations)
