#!/bin/bash
# Balatro Turkish Translations - macOS kurulum betigi
# https://github.com/ceeprus/balatro-turkish-translations
#
# Desteklenen surumler:
#   - Balatro+ (Apple Arcade, /Applications/Balatro.app)  -> denendi (1.0.1o)
#   - Steam (Balatro.app icinde Balatro.love)              -> denenmedi
#
# Kullanim:
#   bash Balatro_TR_macOS.sh           kur / guncelle
#   bash Balatro_TR_macOS.sh --kaldir  Apple Arcade kurulumunu kaldir
#
# Apple Arcade: uygulamaya dokunulmaz (imzasi bozulmaz). LOVE once oyunun
# kayit klasorundeki dosyalari okur; ceviri dosyalari oraya kopyalanir.

set -euo pipefail

REPO_ZIP="https://github.com/ceeprus/balatro-turkish-translations/archive/refs/heads/main.zip"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ARCADE_APP="/Applications/Balatro.app"
ARCADE_SAVE="$HOME/Library/Containers/com.playstack.balatroarcade/Data/Library/Application Support/game"
STEAM_APP="$HOME/Library/Application Support/Steam/steamapps/common/Balatro/Balatro.app"
TEXTURES="8BitDeck.png 8BitDeck_opt2.png BlindChips.png Jokers.png ShopSignAnimation.png Tarots.png Vouchers.png boosters.png icons.png"

echo "========================================="
echo "==     Balatro Turkish Translations    =="
echo "==        macOS kurulum betigi         =="
echo "========================================="
echo

# Kaldirma: yalnizca bu betigin kopyaladigi dosyalar silinir, kayitlara dokunulmaz
if [ "${1:-}" = "--kaldir" ]; then
    [ -d "$ARCADE_SAVE" ] || { echo "Kurulum bulunamadi."; exit 0; }
    rm -f "$ARCADE_SAVE/game.lua" "$ARCADE_SAVE/localization/tr.lua" "$ARCADE_SAVE/resources/fonts/m6x11plus.ttf"
    for r in 1x 2x; do for f in $TEXTURES; do rm -f "$ARCADE_SAVE/resources/textures/$r/$f"; done; done
    find "$ARCADE_SAVE/localization" "$ARCADE_SAVE/resources" -type d -empty -delete 2>/dev/null || true
    echo "Turkce yama kaldirildi. Kayitlariniz yerinde."
    exit 0
fi

# 1) Ceviri dosyalari: repo icindeyse onlari kullan, degilse repoyu indir
#    localization_files        -> Steam
#    localization_files_macOS  -> Apple Arcade (Balatro+)
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT
if [ -f "$SCRIPT_DIR/localization_files_macOS/game.lua" ]; then
    ROOT="$SCRIPT_DIR"
else
    echo "Ceviri dosyalari indiriliyor..."
    curl -fsSL -o "$WORK/tr.zip" "$REPO_ZIP"
    unzip -q "$WORK/tr.zip" -d "$WORK/src"
    ROOT="$(find "$WORK/src" -maxdepth 1 -mindepth 1 -type d | head -1)"
fi
echo "Ceviri dosyalari: $ROOT"
[ -f "$ROOT/localization_files_macOS/game.lua" ] || { echo "HATA: indirilen dosyalarda localization_files_macOS yok. Repoyu indirip betigi repo klasorunden calistirin."; exit 1; }

read -r -p "Gorseller Turkce olsun mu? [E/h] " ans
case "${ans:-E}" in [hHnN]*) ASSETS=false ;; *) ASSETS=true ;; esac

copy_assets() {  # $1 = hedef klasor (SRC once ayarlanmali)
    mkdir -p "$1/localization" "$1/resources/fonts" "$1/resources/textures/1x" "$1/resources/textures/2x"
    cp "$SRC/localization/tr.lua" "$1/localization/tr.lua"
    cp "$SRC/resources/fonts/m6x11plus.ttf" "$1/resources/fonts/m6x11plus.ttf"
    if $ASSETS; then
        for r in 1x 2x; do cp "$SRC/resources/textures/$r/"*.png "$1/resources/textures/$r/"; done
    else
        for r in 1x 2x; do for f in $TEXTURES; do rm -f "$1/resources/textures/$r/$f"; done; done
    fi
}

# 2) Apple Arcade (Balatro+)
if [ -f "$ARCADE_APP/Contents/Resources/game/game.lua" ]; then
    echo "Apple Arcade surumu bulundu: $ARCADE_APP"
    if [ ! -d "$ARCADE_SAVE" ]; then
        echo "HATA: Oyunun kayit klasoru yok. Balatro'yu bir kez acip kapatin, sonra betigi yeniden calistirin."
        exit 1
    fi
    pkill -f "/Applications/Balatro.app/Contents/MacOS/Balatro" 2>/dev/null || true
    SRC="$ROOT/localization_files_macOS"
    copy_assets "$ARCADE_SAVE"
    # Bu game.lua oyunun kendi game.lua'sini okuyup calisirken yamalar;
    # bu yuzden oyun guncellendiginde de calismaya devam eder.
    cp "$SRC/game.lua" "$ARCADE_SAVE/game.lua"

    echo
    echo "Tamam. Balatro'yu her zamanki gibi acin, Ayarlar > Dil menusunden Turkce'yi secin."
    echo "Kaldirmak icin: bash Balatro_TR_macOS.sh --kaldir"
    exit 0
fi

# 3) Steam (denenmedi)
LOVE="$STEAM_APP/Contents/Resources/Balatro.love"
if [ -f "$LOVE" ]; then
    echo "Steam surumu bulundu: $STEAM_APP"
    echo "UYARI: Steam surumu icin bu betik denenmedi."
    read -r -p "Devam edilsin mi? [e/H] " go
    case "${go:-H}" in [eEyY]*) ;; *) echo "Iptal edildi."; exit 0 ;; esac
    SRC="$ROOT/localization_files"
    [ -f "$LOVE.yedek" ] || cp "$LOVE" "$LOVE.yedek"
    echo "Yedek: $LOVE.yedek"
    mkdir -p "$WORK/pack"
    cp "$SRC/game.lua" "$WORK/pack/game.lua"
    copy_assets "$WORK/pack"
    (cd "$WORK/pack" && zip -qr "$LOVE" .)
    echo "Tamam. Oyunu Steam'den acin ve dili Turkce secin."
    echo "Geri almak icin: cp \"$LOVE.yedek\" \"$LOVE\""
    exit 0
fi

echo "Balatro bulunamadi. Apple Arcade surumu /Applications/Balatro.app,"
echo "Steam surumu ~/Library/Application Support/Steam/... altinda olmali."
exit 1
