:: Balatro French Translations
::
:: Script d'installation du pack de langue FR pour Balatro
:: Fichier de langue et assets créés par la communauté Discord (Balatro FR - loc mod) : https://discord.gg/kQMdHTXB3Z
:: Toutes les sources à jour sont disponibles ici : https://github.com/FrBmt-BIGetNouf/balatro-french-translations/
::
:: Ce script utilise Balamod pour injecter les ressources au jeu (https://github.com/balamod/balamod)
::
::
::    ==================================
::    ==  PERDU(E) ? NE PANIQUEZ PAS  ==
::    ==================================
::    Revenez en arrière et CLIQUEZ-DROIT sur le lien qui vous a mené ici, puis "Enregistrer le lien sous...".
::    Double-cliquez ensuite sur le fichier téléchargé pour lancer l'installation.
::
::
::

@echo off
setlocal enabledelayedexpansion

set "colorReset=[0m"
set "resourcesFolder=Balatro_Localization_Resources"

echo =========================================
echo ==     Balatro French Translations     ==
echo ==  Installation du pack de langue FR  ==
echo ==        Traductions et images        ==
echo =========================================

:: Question utilisateur : Les images en Francais doivent-elles être utilisées ?
echo.
echo.
choice /C ON /M "Voulez-vous utiliser les images en Francais ?"
if errorlevel 2 (
    echo Les images ne seront pas ajoutees
    set "download_assets=false"
)   else (
    echo Les images seront ajoutees
    set "download_assets=true"
)

:: Vérificitation de l'installation par défaut de Steam (via libraryfolders.vdf  sur C:)
set "steamLibraryFile=C:\Program Files (x86)\Steam\steamapps\libraryfolders.vdf"

:: S'il n'existe pas, ouverture de l'explorer pour la sélection manuelle de Balatro.exe
if not exist "!steamLibraryFile!" (
    echo.
    echo Oups, merci de nous indiquer ou se trouve Balatro.exe

    set "balatroFile="
    set "dialogTitle=Selectionner balatro.exe"
    set "fileFilter=Balatro Executable (balatro.exe) | balatro.exe"

    for /f "delims=" %%I in ('powershell -Command "& { Add-Type -AssemblyName System.Windows.Forms; $dlg = New-Object System.Windows.Forms.OpenFileDialog; $dlg.Filter = '!fileFilter!'; $dlg.Title = '!dialogTitle!'; $dlg.ShowHelp = $true; $dlg.ShowDialog() | Out-Null; $dlg.FileName }"') do set "selectedFile=%%I"

    if defined selectedFile (
        set "balatroFile=!selectedFile!"
        echo Balatro.exe : !balatroFile!
    ) else (
        echo Balatro.exe : Fichier non selectionne. Installation annulee
        goto :fin
    )
)

:: Création des dossiers de ressources temporaire
if not exist "%resourcesFolder%" mkdir "%resourcesFolder%"
if not exist "%resourcesFolder%\assets" mkdir "%resourcesFolder%\assets"
if not exist "%resourcesFolder%\assets\1x" mkdir "%resourcesFolder%\assets\1x"
if not exist "%resourcesFolder%\assets\2x" mkdir "%resourcesFolder%\assets\2x"

:: Récupération de nom de la dernière release de Balamod
for /f %%a in ('powershell -command "$tag = (Invoke-RestMethod -Uri 'https://api.github.com/repos/balamod/balamod/releases/latest').tag_name; $tag"') do set latestTag=%%a

:: Creation des noms et liens des fichiers. Valable uniquement tant que le fichier windows s'appelle bien balamod-v.y.z-windows.exe.
set "balamodFile=balamod-%latestTag%-windows.exe"
set "balamodFileUrl=https://github.com/balamod/balamod/releases/download/%latestTag%/%balamodFile%"
set "fr_repository=https://raw.githubusercontent.com/FrBmt-BIGetNouf/balatro-french-translations/main/localization"
set "fr_translation=%fr_repository%/fr.lua"
set "fr_assetsBoosters1x=%fr_repository%/assets/1x/boosters.png"
set "fr_assetsBoosters2x=%fr_repository%/assets/2x/boosters.png"
set "fr_assetsTarots1x=%fr_repository%/assets/1x/Tarots.png"
set "fr_assetsTarots2x=%fr_repository%/assets/2x/Tarots.png"
set "fr_assetsVouchers1x=%fr_repository%/assets/1x/Vouchers.png"
set "fr_assetsVouchers2x=%fr_repository%/assets/2x/Vouchers.png"
set "fr_assetsIcons1x=%fr_repository%/assets/1x/icons.png"
set "fr_assetsIcons2x=%fr_repository%/assets/2x/icons.png"
set "fr_assetsBlindChips1x=%fr_repository%/assets/1x/BlindChips.png"
set "fr_assetsBlindChips2x=%fr_repository%/assets/2x/BlindChips.png"
set "fr_assetsJokers1x=%fr_repository%/assets/1x/Jokers.png"
set "fr_assetsJokers2x=%fr_repository%/assets/2x/Jokers.png"
set "fr_assetsShopSignAnimation1x=%fr_repository%/assets/1x/ShopSignAnimation.png"
set "fr_assetsShopSignAnimation2x=%fr_repository%/assets/2x/ShopSignAnimation.png"
set "fr_assets8BitDeck1x=%fr_repository%/assets/1x/8BitDeck.png"
set "fr_assets8BitDeck2x=%fr_repository%/assets/2x/8BitDeck.png"
set "fr_assets8BitDeck_opt21x=%fr_repository%/assets/1x/8BitDeck_opt2.png"
set "fr_assets8BitDeck_opt22x=%fr_repository%/assets/2x/8BitDeck_opt2.png"
set "font_m6x11plus=%fr_repository%/resources/fonts/m6x11plus.ttf"

:: Téléchargement de Balamod
if not exist "%resourcesFolder%\%balamodFile%" (
    echo.
    echo Telechargement de Balamod...
    echo.
    curl --ssl-no-revoke -L -o "%resourcesFolder%\%balamodFile%" %balamodFileUrl%
    echo.
    echo Telechargement de Balamod termine
    echo.
)

:: Téléchargement du pack de langue FR
echo.
echo Telechargement du mod FR...
echo.
curl --ssl-no-revoke -L -o "%resourcesFolder%\fr.lua" %fr_translation%
curl --ssl-no-revoke --create-dirs -L -o "%resourcesFolder%\resources\fonts\m6x11plus.ttf" %font_m6x11plus%

if "%download_assets%"=="true" (
    curl --ssl-no-revoke -L -o "%resourcesFolder%\assets\1x\boosters.png" %fr_assetsBoosters1x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\assets\2x\boosters.png" %fr_assetsBoosters2x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\assets\1x\Tarots.png" %fr_assetsTarots1x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\assets\2x\Tarots.png" %fr_assetsTarots2x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\assets\1x\Vouchers.png" %fr_assetsVouchers1x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\assets\2x\Vouchers.png" %fr_assetsVouchers2x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\assets\1x\icons.png" %fr_assetsIcons1x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\assets\2x\icons.png" %fr_assetsIcons2x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\assets\1x\BlindChips.png" %fr_assetsBlindChips1x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\assets\2x\BlindChips.png" %fr_assetsBlindChips2x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\assets\1x\Jokers.png" %fr_assetsJokers1x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\assets\2x\Jokers.png" %fr_assetsJokers2x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\assets\1x\ShopSignAnimation.png" %fr_assetsShopSignAnimation1x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\assets\2x\ShopSignAnimation.png" %fr_assetsShopSignAnimation2x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\assets\1x\8BitDeck.png" %fr_assets8BitDeck1x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\assets\2x\8BitDeck.png" %fr_assets8BitDeck2x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\assets\1x\8BitDeck_opt2.png" %fr_assets8BitDeck_opt21x%
    curl --ssl-no-revoke -L -o "%resourcesFolder%\assets\2x\8BitDeck_opt2.png" %fr_assets8BitDeck_opt22x%
)

echo.
echo Telechargement du mod FR termine
echo.

:: Injection du pack de langue FR
echo.
echo Installation du pack de langue...
echo.


if not defined balatroFile (
    :: Si Steam installé par défaut, on laisse Balamod chercher le fichier Balatro.
    "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\fr.lua -o localization/fr.lua
    "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\resources\fonts\m6x11plus.ttf -o resources/fonts/m6x11plus.ttf
    if "%download_assets%"=="true" (
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\assets\1x\boosters.png -o resources/textures/1x/boosters.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\assets\2x\boosters.png -o resources/textures/2x/boosters.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\assets\1x\Tarots.png -o resources/textures/1x/Tarots.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\assets\2x\Tarots.png -o resources/textures/2x/Tarots.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\assets\1x\Vouchers.png -o resources/textures/1x/Vouchers.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\assets\2x\Vouchers.png -o resources/textures/2x/Vouchers.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\assets\1x\icons.png -o resources/textures/1x/icons.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\assets\2x\icons.png -o resources/textures/2x/icons.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\assets\1x\BlindChips.png -o resources/textures/1x/BlindChips.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\assets\2x\BlindChips.png -o resources/textures/2x/BlindChips.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\assets\1x\Jokers.png -o resources/textures/1x/Jokers.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\assets\2x\Jokers.png -o resources/textures/2x/Jokers.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\assets\1x\ShopSignAnimation.png -o resources/textures/1x/ShopSignAnimation.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\assets\2x\ShopSignAnimation.png -o resources/textures/2x/ShopSignAnimation.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\assets\1x\8BitDeck.png -o resources/textures/1x/8BitDeck.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\assets\2x\8BitDeck.png -o resources/textures/2x/8BitDeck.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\assets\1x\8BitDeck_opt2.png -o resources/textures/1x/8BitDeck_opt2.png
        "./%resourcesFolder%\%balamodFile%" -x -i .\%resourcesFolder%\assets\2x\8BitDeck_opt2.png -o resources/textures/2x/8BitDeck_opt2.png
    )
) else (
    :: Sinon on lui envoie le dossier du fichier Balatro.exe selectionné précédemment.
    for %%A in ("!balatroFile!") do set "balatroFolder=%%~dpA"
    "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\fr.lua -o localization/fr.lua
    "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\resources\fonts\m6x11plus.ttf -o resources/fonts/m6x11plus.ttf
    if "%download_assets%"=="true" (
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\assets\1x\boosters.png -o resources/textures/1x/boosters.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\assets\2x\boosters.png -o resources/textures/2x/boosters.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\assets\1x\Tarots.png -o resources/textures/1x/Tarots.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\assets\2x\Tarots.png -o resources/textures/2x/Tarots.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\assets\1x\Vouchers.png -o resources/textures/1x/Vouchers.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\assets\2x\Vouchers.png -o resources/textures/2x/Vouchers.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\assets\1x\icons.png -o resources/textures/1x/icons.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\assets\2x\icons.png -o resources/textures/2x/icons.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\assets\1x\BlindChips.png -o resources/textures/1x/BlindChips.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\assets\2x\BlindChips.png -o resources/textures/2x/BlindChips.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\assets\1x\Jokers.png -o resources/textures/1x/Jokers.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\assets\2x\Jokers.png -o resources/textures/2x/Jokers.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\assets\1x\ShopSignAnimation.png -o resources/textures/1x/ShopSignAnimation.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\assets\2x\ShopSignAnimation.png -o resources/textures/2x/ShopSignAnimation.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\assets\1x\8BitDeck.png -o resources/textures/1x/8BitDeck.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\assets\2x\8BitDeck.png -o resources/textures/2x/8BitDeck.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\assets\1x\8BitDeck_opt2.png -o resources/textures/1x/8BitDeck_opt2.png
        "./%resourcesFolder%\%balamodFile%" -b !balatroFolder! -x -i .\%resourcesFolder%\assets\2x\8BitDeck_opt2.png -o resources/textures/2x/8BitDeck_opt2.png
    )
)

echo %colorReset%
echo.
echo Installation du pack de langue terminee

:: Suppression des fichiers ressources
rd /s /q "%resourcesFolder%"
echo Balatro a ete mis a jour !

:fin
echo.
echo.
echo.
pause
