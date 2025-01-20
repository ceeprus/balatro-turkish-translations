:: Balatro Turkish Translations
::
:: Balatro icin TR dil paketi kurulum scripti
:: Ceviride yardimda bulunmak icin Discord (Balatro TR - Dil modu sunucumuza katilabilirsiniz: https://discord.gg/dfy7b3zsVN 
:: Tum guncel kaynaklara buradan ulagabilirsiniz : https://github.com/ceeprus/balatro-turkish-translations
::
:: Bu dosya oyuna mod eklemek icin Balamod kullanmaktadir (https://github.com/balamod/balamod)
::
::
::    ==================================
::    ==  Kayboldun mug Panik yapma!  ==
::    ==================================
::    Geri donun ve sizi buraya getiren baglantiya SAg TIKLAYIN, ardindan gBaglantiyi farkli kaydet...
::    Ardindan kurulumu baglatmak icin indirilen dosyaya cift tiklayin.
::
::
::

@echo off
setlocal enabledelayedexpansion
setlocal EnableExtensions

set "colorReset=[0m"
set "resourcesFolder=Balatro_Localization_Resources"

echo =========================================
echo ==     Balatro Turkish Translations    ==
echo ==     TR Dil paketinin yuklenmesi     ==
echo ==        Ceviriler ve resimler        ==
echo =========================================

:: Kullanici sorusu: Turkce resimler kullanilmali mig
echo.
echo.
CHOICE /C YN /M "Gorselleri Turkce olarak mi kullanmak istiyorsunuz"
if %errorlevel% equ 2 (
    echo Goruntuleri Ekleme
    set "download_assets=false"
) else (
    echo Goruntuleri Ekle
    set "download_assets=true"
)

:: Varsayilan Steam kurulumunu kontrol etme (libraryfolders.vdf uzerinden)
set "steamLibraryFile=C:\Program Files (x86)\Steam\steamapps\libraryfolders.vdf"

:: Eger mevcut degilse, Balatro.exe dosyasini elle secmek icin gezgini acin
if not exist "!steamLibraryFile!" (
    echo.
    echo Oops, lutfen bize Balatro.exe dosyasini nerede bulacagimizi gosterin.

    set "balatroFile="
    set "dialogTitle=balatro.exe seciniz."
    set "fileFilter=Balatro Executable (balatro.exe) | balatro.exe"

    for /f "delims=" %%I in ('powershell -Command "& { Add-Type -AssemblyName System.Windows.Forms; $dlg = New-Object System.Windows.Forms.OpenFileDialog; $dlg.Filter = '!fileFilter!'; $dlg.Title = '!dialogTitle!'; $dlg.ShowHelp = $true; $dlg.ShowDialog() | Out-Null; $dlg.FileName }"') do set "selectedFile=%%I"

    if defined selectedFile (
        set "balatroFile=!selectedFile!"
        echo Balatro.exe : !balatroFile!
    ) else (
        echo Balatro.exe : Dosyasi secili degil. Kurulum iptal edildi.
        goto :end
    )
)

:: Gecici klasorleri olugturma
if not exist "%resourcesFolder%" mkdir "%resourcesFolder%"
if not exist "%resourcesFolder%\resources\textures" mkdir "%resourcesFolder%\resources\textures"
if not exist "%resourcesFolder%\resources\textures\1x" mkdir "%resourcesFolder%\resources\textures\1x"
if not exist "%resourcesFolder%\resources\textures\2x" mkdir "%resourcesFolder%\resources\textures\2x"

:: En son Balamod surumunun adini alma
for /f %%a in ('powershell -command "$tag = (Invoke-RestMethod -Uri 'https://api.github.com/repos/balamod/balamod/releases/latest' -TimeoutSec 10).tag_name; $tag"') do set latestTag=%%a

:: Dosya adlarinin ve baglantilarinin olugturulmasi. Yalnizca windows dosyasi balamod-v.y.z-windows.exe olarak adlandirildigi surece gecerlidir.
set "balamodFile=balamod-%latestTag%-windows.exe"
set "balamodFileUrl=https://github.com/balamod/balamod/releases/download/%latestTag%/%balamodFile%"
set "tr_repository=https://raw.githubusercontent.com/ceeprus/balatro-turkish-translations/main/localization_files"
set "tr_translation=%tr_repository%/localization/tr.lua"
set "tr_game=%tr_repository%/game.lua"
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

:: Balamod indir
if not exist "%resourcesFolder%\%balamodFile%" (
    echo.
    echo Balamod gondiriliyor...
    echo.
    curl --ssl-no-revoke -L -o "%resourcesFolder%\%balamodFile%" %balamodFileUrl%
    echo.
    echo Balamod indirildi
    echo.
)

:: TR dil paketi indiriliyor
echo.
echo TR modunu indiriliyor...
echo.

curl --ssl-no-revoke -L -o "%resourcesFolder%/tr.lua" %tr_translation%
curl --ssl-no-revoke -L -o "%resourcesFolder%/game.lua" %tr_game%

if "%download_assets%"=="true" (
    curl --ssl-no-revoke -L -o "%resourcesFolder%/resources/textures/1x/boosters.png" %tr_assetsBoosters1x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%/resources/textures/2x/boosters.png" %tr_assetsBoosters2x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%/resources/textures/1x/Tarots.png" %tr_assetsTarots1x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%/resources/textures/2x/Tarots.png" %tr_assetsTarots2x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%/resources/textures/1x/Vouchers.png" %tr_assetsVouchers1x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%/resources/textures/2x/Vouchers.png" %tr_assetsVouchers2x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%/resources/textures/1x/icons.png" %tr_assetsIcons1x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%/resources/textures/2x/icons.png" %tr_assetsIcons2x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%/resources/textures/1x/BlindChips.png" %tr_assetsBlindChips1x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%/resources/textures/2x/BlindChips.png" %tr_assetsBlindChips2x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%/resources/textures/1x/Jokers.png" %tr_assetsJokers1x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%/resources/textures/2x/Jokers.png" %tr_assetsJokers2x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%/resources/textures/1x/ShopSignAnimation.png" %tr_assetsShopSignAnimation1x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%/resources/textures/2x/ShopSignAnimation.png" %tr_assetsShopSignAnimation2x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%/resources/textures/1x/8BitDeck.png" %tr_assets8BitDeck1x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%/resources/textures/2x/8BitDeck.png" %tr_assets8BitDeck2x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%/resources/textures/1x/8BitDeck_opt2.png" %tr_assets8BitDeck_opt21x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%/resources/textures/2x/8BitDeck_opt2.png" %tr_assets8BitDeck_opt22x%
)

echo.
echo TR dil paketi enjeksiyonu 
echo.

:: TR dil paketi enjeksiyonu
echo.
echo Dil paketi yukleniyor...
echo.


if not defined balatroFile (
    :: Steam varsayilan olarak yukluyse, Balamod'un Balatro dosyasini aramasina izin verin.
    "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\tr.lua -o localization/tr.lua
    "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\game.lua -o game.lua
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
    :: Aksi takdirde, daha once secilen Balatro.exe dosyasini iceren klasoru gondeririz.
    for %%A in ("!balatroFile!") do set "balatroFolder=%%~dpA"
    "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\tr.lua -o localization/tr.lua
    "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\game.lua -o game.lua
    if "%download_assets%"=="true" (
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\textures\1x\boosters.png -o resources/textures/1x/boosters.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\textures\2x\boosters.png -o resources/textures/2x/boosters.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\textures\1x\Tarots.png -o resources/textures/1x/Tarots.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\textures\2x\Tarots.png -o resources/textures/2x/Tarots.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\textures\1x\Vouchers.png -o resources/textures/1x/Vouchers.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\textures\2x\Vouchers.png -o resources/textures/2x/Vouchers.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\textures\1x\icons.png -o resources/textures/1x/icons.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\textures\2x\icons.png -o resources/textures/2x/icons.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\textures\1x\BlindChips.png -o resources/textures/1x/BlindChips.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\textures\2x\BlindChips.png -o resources/textures/2x/BlindChips.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\textures\1x\Jokers.png -o resources/textures/1x/Jokers.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\textures\2x\Jokers.png -o resources/textures/2x/Jokers.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\textures\1x\ShopSignAnimation.png -o resources/textures/1x/ShopSignAnimation.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\textures\2x\ShopSignAnimation.png -o resources/textures/2x/ShopSignAnimation.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\textures\1x\8BitDeck.png -o resources/textures/1x/8BitDeck.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\textures\2x\8BitDeck.png -o resources/textures/2x/8BitDeck.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\textures\1x\8BitDeck_opt2.png -o resources/textures/1x/8BitDeck_opt2.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\textures\2x\8BitDeck_opt2.png -o resources/textures/2x/8BitDeck_opt2.png
    )
)

echo %colorReset%
echo.
echo Dil paketi kuruldu !

:: Kaynak dosyalarini silme
if exist "%resourcesFolder%" rd /s /q "%resourcesFolder%"
echo Balatro guncellendi !

:end
echo.
echo.
echo.
pause
