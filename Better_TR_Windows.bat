:: Balatro Turkish Translations
::
:: Balatro iáin TR dil paketi kurulum scripti
:: Äeviride yard’mda bulunmak iáin Discord (Balatro TR - Dil modu sunucumuza kat’labilirsiniz: https://discord.gg/dfy7b3zsVN 
:: TÅm gÅncel kaynaklara buradan ula?abilirsiniz : https://github.com/ceeprus/balatro-turkish-translations
::
:: Bu dosya oyuna mod eklemek iáin Balamod kullanmaktad’r (https://github.com/balamod/balamod)
::
::
::    ==================================
::    ==  Kayboldun mu? Panik yapma!  ==
::    ==================================
::    Geri dînÅn ve sizi buraya getiren ba?lant’ya SA? TIKLAYIN, ard’ndan ?Ba?lant’y’ farkl’ kaydet...?.
::    Ard’ndan kurulumu ba?latmak iáin indirilen dosyaya áift t’klay’n.
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
echo ==     TR Dil paketinin yÅklenmesi     ==
echo ==        Äeviriler ve resimler        ==
echo =========================================

:: Kullan’c’ sorusu: TÅrkáe resimler kullan’lmal’ m’?
echo.
echo.
CHOICE /C YN /M "Gîrselleri TÅrkáe olarak m’ kullanmak istiyorsunuz?"
if %errorlevel% equ 2 (
    echo GîrÅntÅleri Ekleme
    set "download_assets=false"
) else (
    echo GîrÅntÅleri Ekle
    set "download_assets=true"
)

:: Varsay’lan Steam kurulumunu kontrol etme (libraryfolders.vdf Åzerinden)
set "steamLibraryFile=C:\Program Files (x86)\Steam\steamapps\libraryfolders.vdf"

:: E?er mevcut de?ilse, Balatro.exe dosyas’n’ elle seámek iáin gezgini aá’n
if not exist "!steamLibraryFile!" (
    echo.
    echo Oops, lÅtfen bize Balatro.exe dosyas’n’ nerede bulaca?’m’z’ gîsterin.

    set "balatroFile="
    set "dialogTitle=balatro.exe seáiniz."
    set "fileFilter=Balatro Executable (balatro.exe) | balatro.exe"

    for /f "delims=" %%I in ('powershell -Command "& { Add-Type -AssemblyName System.Windows.Forms; $dlg = New-Object System.Windows.Forms.OpenFileDialog; $dlg.Filter = '!fileFilter!'; $dlg.Title = '!dialogTitle!'; $dlg.ShowHelp = $true; $dlg.ShowDialog() | Out-Null; $dlg.FileName }"') do set "selectedFile=%%I"

    if defined selectedFile (
        set "balatroFile=!selectedFile!"
        echo Balatro.exe : !balatroFile!
    ) else (
        echo Balatro.exe : Dosyas’ seáili de?il. Kurulum iptal edildi.
        goto :end
    )
)

:: Geáici klasîrleri olu?turma
if not exist "%resourcesFolder%" mkdir "%resourcesFolder%"
if not exist "%resourcesFolder%\resources\textures" mkdir "%resourcesFolder%\resources\textures"
if not exist "%resourcesFolder%\resources\textures\1x" mkdir "%resourcesFolder%\resources\textures\1x"
if not exist "%resourcesFolder%\resources\textures\2x" mkdir "%resourcesFolder%\resources\textures\2x"

:: En son Balamod sÅrÅmÅnÅn ad’n’ alma
for /f %%a in ('powershell -command "$tag = (Invoke-RestMethod -Uri 'https://api.github.com/repos/balamod/balamod/releases/latest' -TimeoutSec 10).tag_name; $tag"') do set latestTag=%%a

:: Dosya adlar’n’n ve ba?lant’lar’n’n olu?turulmas’. Yaln’zca windows dosyas’ balamod-v.y.z-windows.exe olarak adland’r’ld’?’ sÅrece geáerlidir.
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
    echo Balamod ?ndiriliyor...
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
echo Dil paketi yÅkleniyor...
echo.


if not defined balatroFile (
    :: Steam varsay’lan olarak yÅklÅyse, Balamod'un Balatro dosyas’n’ aramas’na izin verin.
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
    :: Aksi takdirde, daha înce seáilen Balatro.exe dosyas’n’ iáeren klasîrÅ gîndeririz.
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

:: Kaynak dosyalar’n’ silme
if exist "%resourcesFolder%" rd /s /q "%resourcesFolder%"
echo Balatro gÅncellendi !

:end
echo.
echo.
echo.
pause