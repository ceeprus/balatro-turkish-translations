:: Balatro Turkish Translations
::
:: Balatro için TR dil paketi kurulum scripti
:: Çeviride yardımda bulunmak için Discord (Balatro TR - Dil modu sunucumuza katılabilirsiniz: https://discord.gg/dfy7b3zsVN 

:: Tüm güncel kaynaklara buradan ulaşabilirsiniz : https://github.com/ceeprus/balatro-turkish-translations
::
:: Bu dosya oyuna mod eklemek için Balamod kullanmaktadır (https://github.com/balamod/balamod)
::
::
::    ==================================
::    ==  Kayboldun mu? Panik yapma!  ==
::    ==================================
::    Geri dönün ve sizi buraya getiren bağlantıya SAĞ TIKLAYIN, ardından “Bağlantıyı farklı kaydet...”.
::    Ardından kurulumu başlatmak için indirilen dosyaya çift tıklayın.
::
::
::

@echo off
setlocal enabledelayedexpansion

set "colorReset=[0m"
set "resourcesFolder=Balatro_Localization_Resources"

echo =========================================
echo ==     Balatro Turkish Translations    ==
echo ==     TR Dil paketinin yüklenmesi     ==
echo ==        Çeviriler ve resimler        ==
echo =========================================

:: Kullanıcı sorusu: Türkçe resimler kullanılmalı mı? ?
echo.
echo.
CHOICE /C YN /M  "Görselleri Türkçe olarak mı kullanmak istiyorsunuz ?"
if errorlevel 2 (
    echo Görüntüleri Ekleme
    set "download_assets=false"
)   else (
    echo Görüntüleri Ekle
    set "download_assets=true"
)

:: Varsayılan Steam kurulumunu kontrol etme (libraryfolders.vdf üzerinden)
set "steamLibraryFile=C:\Program Files (x86)\Steam\steamapps\libraryfolders.vdf"

:: Eğer mevcut değilse, Balatro.exe dosyasını elle seçmek için gezgini açın
if not exist "!steamLibraryFile!" (
    echo.
    echo Oops, lütfen bize Balatro.exe dosyasını nerede bulacağımızı gösterin.

    set "balatroFile="
    set "dialogTitle=balatro.exe seçiniz."
    set "fileFilter=Balatro Executable (balatro.exe) | balatro.exe"

    for /f "delims=" %%I in ('powershell -Command "& { Add-Type -AssemblyName System.Windows.Forms; $dlg = New-Object System.Windows.Forms.OpenFileDialog; $dlg.Filter = '!fileFilter!'; $dlg.Title = '!dialogTitle!'; $dlg.ShowHelp = $true; $dlg.ShowDialog() | Out-Null; $dlg.FileName }"') do set "selectedFile=%%I"

    if defined selectedFile (
        set "balatroFile=!selectedFile!"
        echo Balatro.exe : !balatroFile!
    ) else (
        echo Balatro.exe : Dosyası seçili değil. Kurulum iptal edildi.
        goto :fin
    )
)

:: Geçici klasörleri oluşturma
if not exist "%resourcesFolder%" mkdir "%resourcesFolder%"
if not exist "%resourcesFolder%\resources\textures" mkdir "%resourcesFolder%\resources\textures"
if not exist "%resourcesFolder%\resources\textures\1x" mkdir "%resourcesFolder%\resources\textures\1x"
if not exist "%resourcesFolder%\resources\textures\2x" mkdir "%resourcesFolder%\resources\textures\2x"

:: En son Balamod sürümünün adını alma
for /f %%a in ('powershell -command "$tag = (Invoke-RestMethod -Uri 'https://api.github.com/repos/balamod/balamod/releases/latest').tag_name; $tag"') do set latestTag=%%a

:: Dosya adlarının ve bağlantılarının oluşturulması. Yalnızca windows dosyası balamod-v.y.z-windows.exe olarak adlandırıldığı sürece geçerlidir.
set "balamodFile=balamod-%latestTag%-windows.exe"
set "balamodFileUrl=https://github.com/balamod/balamod/releases/download/%latestTag%/%balamodFile%"
set "tr_repository=https://github.com/ceeprus/balatro-turkish-translations/tree/main/localization_files"
set "tr_translation=%tr_repository%/localization/tr.lua"
set "tr_translation=%tr_repository%/game.lua"
set "tr_assetsBoosters1x=%tr_repository%/resources/textures/1x/boosters.png"
set "tr_assetsBoosters2x=%tr_repository%/resources/textures/2x/boosters.png"
set "tr_assetsTarots1x=%tr_repository%/resources/textures/1x/Tarots.png"
set "tr_assetsTarots2x=%tr_repository%/resources/textures/2x/Tarots.png"
set "tr_assetsVouchers1x=%tr_repository%/resources/textures/1x/Vouchers.png"
set "tr_assetsVouchers2x=%tr_repository%/resources/textures/2x/Vouchers.png"
set "tr_assetsIcons1x=%tr_repository%/resources/textures/1x/icons.png"
set "tr_assetsIcons2x=%tr_repository%/resources/textures/2x/icons.png"
set "tr_assetsBlindChips1x=%tr_repository%/resources/textures/1x/BlindChips.png"
set "tr_assetsBlindChips2x=%tr_repository%/resources/textures/2x/BlindChips.png"
set "tr_assetsJokers1x=%tr_repository%/resources/textures/1x/Jokers.png"
set "tr_assetsJokers2x=%tr_repository%/resources/textures/2x/Jokers.png"
set "tr_assetsShopSignAnimation1x=%tr_repository%/resources/textures/1x/ShopSignAnimation.png"
set "tr_assetsShopSignAnimation2x=%tr_repository%/resources/textures/2x/ShopSignAnimation.png"
set "tr_assets8BitDeck1x=%tr_repository%/resources/textures/1x/8BitDeck.png"
set "tr_assets8BitDeck2x=%tr_repository%/resources/textures/2x/8BitDeck.png"
set "tr_assets8BitDeck_opt21x=%tr_repository%/resources/textures/1x/8BitDeck_opt2.png"
set "tr_assets8BitDeck_opt22x=%tr_repository%/resources/textures/2x/8BitDeck_opt2.png"
set "font_m6x11plus=%tr_repository%/resources/textures/fonts/m6x11plus.ttf"

:: Balamod İndir
if not exist "%resourcesFolder%\%balamodFile%" (
    echo.
    echo Balamod İndiriliyor...
    echo.
    curl --ssl-no-revoke -L -o "%resourcesFolder%\%balamodFile%" %balamodFileUrl%
    echo.
    echo Balamod indirildi
    echo.
)

:: Téléchargement du pack de langue FR
echo.
echo TR modunu indiriliyor...
echo.
curl --ssl-no-revoke -L -o "%resourcesFolder%\localization\tr.lua" %tr_translation%
curl --ssl-no-revoke -L -o "%resourcesFolder%\game.lua" %tr_translation%

curl --ssl-no-revoke --create-dirs -L -o "%resourcesFolder%\resources\fonts\m6x11plus.ttf" %font_m6x11plus%

if "%download_assets%"=="true" (
    curl --ssl-no-revoke -L -o "%resourcesFolder%\resources\textures\1x\boosters.png" %tr_assetsBoosters1x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\resources\textures\2x\boosters.png" %tr_assetsBoosters2x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\resources\textures\1x\Tarots.png" %tr_assetsTarots1x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\resources\textures\2x\Tarots.png" %tr_assetsTarots2x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\resources\textures\1x\Vouchers.png" %tr_assetsVouchers1x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\resources\textures\2x\Vouchers.png" %tr_assetsVouchers2x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\resources\textures\1x\icons.png" %tr_assetsIcons1x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\resources\textures\2x\icons.png" %tr_assetsIcons2x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\resources\textures\1x\BlindChips.png" %tr_assetsBlindChips1x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\resources\textures\2x\BlindChips.png" %tr_assetsBlindChips2x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\resources\textures\1x\Jokers.png" %tr_assetsJokers1x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\resources\textures\2x\Jokers.png" %tr_assetsJokers2x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\resources\textures\1x\ShopSignAnimation.png" %tr_assetsShopSignAnimation1x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\resources\textures\2x\ShopSignAnimation.png" %tr_assetsShopSignAnimation2x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\resources\textures\1x\8BitDeck.png" %tr_assets8BitDeck1x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\resources\textures\2x\8BitDeck.png" %tr_assets8BitDeck2x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\resources\textures\1x\8BitDeck_opt2.png" %tr_assets8BitDeck_opt21x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\resources\textures\2x\8BitDeck_opt2.png" %tr_assets8BitDeck_opt22x%
)

echo.
echo TR dil paketi enjeksiyonu 
echo.

:: Injection du pack de langue FR
echo.
echo Dil pakedi yükleniyor...
echo.


if not defined balatroFile (
    :: Steam varsayılan olarak yüklüyse, Balamod'un Balatro dosyasını aramasına izin verin.
    "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\fr.lua -o localization/fr.lua
    "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\game.lua -o /game.lua
    "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\resources\textures\fonts\m6x11plus.ttf -o resources/fonts/m6x11plus.ttf
    if "%download_assets%"=="true" (
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\resources\textures\1x\boosters.png -o resources/textures/1x/boosters.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\resources\textures\2x\boosters.png -o resources/textures/2x/boosters.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\resources\textures\1x\Tarots.png -o resources/textures/1x/Tarots.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\resources\textures\2x\Tarots.png -o resources/textures/2x/Tarots.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\resources\textures\1x\Vouchers.png -o resources/textures/1x/Vouchers.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\resources\textures\2x\Vouchers.png -o resources/textures/2x/Vouchers.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\resources\textures\1x\icons.png -o resources/textures/1x/icons.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\resources\textures\2x\icons.png -o resources/textures/2x/icons.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\resources\textures\1x\BlindChips.png -o resources/textures/1x/BlindChips.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\resources\textures\2x\BlindChips.png -o resources/textures/2x/BlindChips.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\resources\textures\1x\Jokers.png -o resources/textures/1x/Jokers.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\resources\textures\2x\Jokers.png -o resources/textures/2x/Jokers.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\resources\textures\1x\ShopSignAnimation.png -o resources/textures/1x/ShopSignAnimation.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\resources\textures\2x\ShopSignAnimation.png -o resources/textures/2x/ShopSignAnimation.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\resources\textures\1x\8BitDeck.png -o resources/textures/1x/8BitDeck.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\resources\textures\2x\8BitDeck.png -o resources/textures/2x/8BitDeck.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\resources\textures\1x\8BitDeck_opt2.png -o resources/textures/1x/8BitDeck_opt2.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\resources\textures\2x\8BitDeck_opt2.png -o resources/textures/2x/8BitDeck_opt2.png
    )
) else (
    :: Aksi takdirde, daha önce seçilen Balatro.exe dosyasını içeren klasörü göndeririz.
    for %%A in ("!balatroFile!") do set "balatroFolder=%%~dpA"
    "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\fr.lua -o localization/fr.lua
    "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\game.lua -o /game.lua
    "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\resources\textures\fonts\m6x11plus.ttf -o resources/fonts/m6x11plus.ttf
    if "%download_assets%"=="true" (
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\resources\textures\1x\boosters.png -o resources/textures/1x/boosters.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\resources\textures\2x\boosters.png -o resources/textures/2x/boosters.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\resources\textures\1x\Tarots.png -o resources/textures/1x/Tarots.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\resources\textures\2x\Tarots.png -o resources/textures/2x/Tarots.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\resources\textures\1x\Vouchers.png -o resources/textures/1x/Vouchers.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\resources\textures\2x\Vouchers.png -o resources/textures/2x/Vouchers.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\resources\textures\1x\icons.png -o resources/textures/1x/icons.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\resources\textures\2x\icons.png -o resources/textures/2x/icons.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\resources\textures\1x\BlindChips.png -o resources/textures/1x/BlindChips.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\resources\textures\2x\BlindChips.png -o resources/textures/2x/BlindChips.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\resources\textures\1x\Jokers.png -o resources/textures/1x/Jokers.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\resources\textures\2x\Jokers.png -o resources/textures/2x/Jokers.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\resources\textures\1x\ShopSignAnimation.png -o resources/textures/1x/ShopSignAnimation.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\resources\textures\2x\ShopSignAnimation.png -o resources/textures/2x/ShopSignAnimation.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\resources\textures\1x\8BitDeck.png -o resources/textures/1x/8BitDeck.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\resources\textures\2x\8BitDeck.png -o resources/textures/2x/8BitDeck.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\resources\textures\1x\8BitDeck_opt2.png -o resources/textures/1x/8BitDeck_opt2.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\resources\textures\2x\8BitDeck_opt2.png -o resources/textures/2x/8BitDeck_opt2.png
    )
)

echo %colorReset%
echo.
echo Dil paketi kurulumu tamamlandı

:: Kaynak dosyalarını silme
rd /s /q "%resourcesFolder%"
echo Balatro güncellendi !

:fin
echo.
echo.
echo.
pause
