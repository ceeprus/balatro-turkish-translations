#!/bin/bash
# Balatro Turkish Translations - macOS kurulum betigi
# https://github.com/ceeprus/balatro-turkish-translations
#
# Desteklenen surumler:
#   - Balatro+ (Apple Arcade, /Applications/Balatro.app)  -> denendi (1.0.1o)
#   - Steam (Balatro.app icinde Balatro.love)              -> denenmedi
#
# Kullanim:  bash Balatro_TR_macOS.sh
#
# Apple Arcade surumu imzali oldugu icin orijinal uygulamaya dokunulmaz:
#   ~/Applications/Balatro TR.app      (Turkce yamali kopya)
#   ~/Applications/Balatro Türkçe.app  (oyunu acan baslatici)
# Yamali kopyanin imzasi bozulur; macOS onu "hasarli" der. Oyunu her zaman
# "Balatro Türkçe.app" ile acin. Uyaridaki "Cop Sepeti'ne Tasi" dugmesine
# basmayin: yamali kopya silinir.

set -euo pipefail

REPO_ZIP="https://github.com/ceeprus/balatro-turkish-translations/releases/latest/download/Balatro_TR_Manual_Install.zip"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ARCADE_APP="/Applications/Balatro.app"
STEAM_APP="$HOME/Library/Application Support/Steam/steamapps/common/Balatro/Balatro.app"
TR_APP="$HOME/Applications/Balatro TR.app"
LAUNCHER="$HOME/Applications/Balatro Türkçe.app"

echo "========================================="
echo "==     Balatro Turkish Translations    =="
echo "==        macOS kurulum betigi         =="
echo "========================================="
echo

# 1) Ceviri dosyalari: repo icindeyse onlari kullan, degilse son surumu indir
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT
if [ -f "$SCRIPT_DIR/localization_files/localization/tr.lua" ]; then
    SRC="$SCRIPT_DIR/localization_files"
    echo "Ceviri dosyalari: $SRC"
else
    echo "Ceviri dosyalari indiriliyor..."
    curl -fsSL -o "$WORK/tr.zip" "$REPO_ZIP"
    unzip -q "$WORK/tr.zip" -d "$WORK/src"
    SRC="$WORK/src"
fi

read -r -p "Gorseller Turkce olsun mu? [E/h] " ans
case "${ans:-E}" in [hHnN]*) ASSETS=false ;; *) ASSETS=true ;; esac

copy_assets() {  # $1 = hedef oyun klasoru
    cp "$SRC/localization/tr.lua" "$1/localization/tr.lua"
    cp "$SRC/resources/fonts/m6x11plus.ttf" "$1/resources/fonts/m6x11plus.ttf"
    if $ASSETS; then
        for r in 1x 2x; do cp "$SRC/resources/textures/$r/"*.png "$1/resources/textures/$r/"; done
    fi
}

# 2) Apple Arcade (Balatro+)
if [ -f "$ARCADE_APP/Contents/Resources/game/game.lua" ]; then
    echo "Apple Arcade surumu bulundu: $ARCADE_APP"
    pkill -f "/Applications/Balatro.app/Contents/MacOS/Balatro" 2>/dev/null || true
    pkill -f "Balatro TR.app/Contents/MacOS/Balatro" 2>/dev/null || true
    mkdir -p "$HOME/Applications"
    if [ -e "$TR_APP" ]; then
        echo "Eski yamali kopya yenileniyor: $TR_APP"
        rm -rf "$TR_APP"
    fi
    cp -Rp "$ARCADE_APP" "$TR_APP"
    chmod -R u+w "$TR_APP"
    GAME="$TR_APP/Contents/Resources/game"
    copy_assets "$GAME"

    # Arcade game.lua'si Steam'inkinden farkli: dosyayi degistirmek yerine
    # yalnizca Turkce dil satirini ve Ingilizce yedekli yuklemeyi ekle.
    TRLINE="$(grep -F "['tr'] = {" "$SRC/game.lua" | head -1)"
    [ -n "$TRLINE" ] || { echo "HATA: game.lua icinde tr satiri yok"; exit 1; }
    TRLINE="$TRLINE" awk '
        { print }
        /\[.ru.\] = \{font/ && !done_lang { print ENVIRON["TRLINE"]; done_lang=1 }
        /self\.localization = assert\(loadstring\(love\.filesystem\.read\(.localization\/.\.\.G\.SETTINGS\.language/ && !done_load {
            print "      if G.SETTINGS.language == \x27tr\x27 then"
            print "        local base = assert(loadstring(love.filesystem.read(\x27localization/en-us.lua\x27)))()"
            print "        local function merge(b, o) for k, v in pairs(o) do if type(v) == \x27table\x27 and type(b[k]) == \x27table\x27 and #v == 0 then merge(b[k], v) else b[k] = v end end end"
            print "        merge(base, self.localization)"
            print "        self.localization = base"
            print "      end"
            done_load=1
        }
        END { if (!done_lang || !done_load) exit 3 }
    ' "$GAME/game.lua" > "$WORK/game.lua" || { echo "HATA: game.lua yamalanamadi (oyun surumu farkli olabilir)"; exit 1; }
    cp "$WORK/game.lua" "$GAME/game.lua"

    # Imza bozuldugu icin kopya Finder'dan acilmaz ve bir uygulamanin alt sureci
    # olarak baslatilinca macOS onu oldurur. Terminal uzerinden calisinca aciliyor;
    # baslatici bu yuzden icindeki .command dosyasini Terminal'de acar.
    # (Kopyayi ad-hoc imzalamak da calisir ama iCloud kayitlari yuklenmez.)
    rm -rf "$LAUNCHER"
    osacompile -o "$LAUNCHER" -e 'do shell script "open " & quoted form of (POSIX path of (path to me) & "Contents/Resources/baslat.command")'
    printf '#!/bin/bash\nnohup "%s" >/dev/null 2>&1 &\ndisown\nexit 0\n' "$TR_APP/Contents/MacOS/Balatro" > "$LAUNCHER/Contents/Resources/baslat.command"
    chmod +x "$LAUNCHER/Contents/Resources/baslat.command"
    cp "$ARCADE_APP/Contents/Resources/OS X AppIcon.icns" "$LAUNCHER/Contents/Resources/applet.icns" 2>/dev/null || true
    codesign --force -s - "$LAUNCHER" 2>/dev/null || true
    touch "$LAUNCHER"

    echo
    echo "Tamam. Oyunu su uygulamayla acin: $LAUNCHER"
    echo "Ayarlar > Dil menusunden Turkce'yi secin."
    echo "Oyun guncellenince betigi yeniden calistirin."
    exit 0
fi

# 3) Steam (denenmedi)
LOVE="$STEAM_APP/Contents/Resources/Balatro.love"
if [ -f "$LOVE" ]; then
    echo "Steam surumu bulundu: $STEAM_APP"
    echo "UYARI: Steam surumu icin bu betik denenmedi."
    read -r -p "Devam edilsin mi? [e/H] " go
    case "${go:-H}" in [eEyY]*) ;; *) echo "Iptal edildi."; exit 0 ;; esac
    [ -f "$LOVE.yedek" ] || cp "$LOVE" "$LOVE.yedek"
    echo "Yedek: $LOVE.yedek"
    mkdir -p "$WORK/pack/localization" "$WORK/pack/resources/fonts" "$WORK/pack/resources/textures/1x" "$WORK/pack/resources/textures/2x"
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
