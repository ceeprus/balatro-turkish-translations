# Kurulum Yöntemleri

Balatro'nun Türkçe çevirisini kullanmanın birçok yolu vardır; size en uygun olanı seçin.

## Hiçbir şey bilmiyorum (ve Windows kullanıyorum)

Buraya bak 👉 [**Balatro'nun TR çevirisini yüklemek için buraya tıklayın Windows**](QUICKSTART.md).

## Hiçbir şey bilmiyorum (ve macOS kullanıyorum)

Buraya bak 👉 [**Balatro'nun TR çevirisini yüklemek için buraya tıklayın macOS**](QUICKSTART_macOS.md).

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

Kolay yol: [QUICKSTART_macOS.md](QUICKSTART_macOS.md) (`bash Balatro_TR_macOS.sh`).

Elle kurulum:

1. Balatro'yu en az bir kez açıp **kapatın**.
2. Finder'da `Git > Klasöre Git` ile şu klasörü açın: `~/Library/Containers/com.playstack.balatroarcade/Data/Library/Application Support/game/`
3. `localization_files_macOS` klasörünün içindekileri (`game.lua`, `localization`, `resources`) bu klasöre kopyalayın.
4. **Oyunu başlatın** ve Ayarlar > Dil menüsünden Türkçe'yi seçin. Tebrikler, Balatro'yu Türkçe'ye çevirdin 🥳

Neden `Balatro.app`'in içine değil? Uygulama Apple imzalıdır; içindeki dosyalar değişince macOS onu "hasar görmüş" sayar. LÖVE dosyaları önce kayıt klasöründen okuduğu için uygulamaya dokunmaya gerek yoktur. Apple Arcade'in `game.lua`'sı Steam'inkinden farklı olduğundan `localization_files_macOS/game.lua` tam bir oyun dosyası değil, oyunun kendi `game.lua`'sını okuyup Türkçe dil satırını ve İngilizce yedekli yüklemeyi ekleyen bir yükleyicidir.

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
