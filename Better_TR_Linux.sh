#!/bin/bash

# Balatro Turkish Translations
#
# Balatro için TR dil paketi kurulum scripti
# Çeviride yardımda bulunmak için Discord (Balatro TR - Dil modu sunucumuza katılabilirsiniz: https://discord.gg/dfy7b3zsVN 

# Tüm güncel kaynaklara buradan ulaşabilirsiniz : https://github.com/ceeprus/balatro-turkish-translations
#
# Bu dosya oyuna mod eklemek için Balamod kullanmaktadır (https://github.com/balamod/balamod)
#
#
#    ==================================
#    ==  Kayboldun mu? Panik yapma!  ==
#    ==================================
#    Revenez en arrière et CLIQUEZ-DROIT sur le lien qui vous a mené ici, puis "Enregistrer le lien sous...".
#    Double-cliquez ensuite sur le fichier téléchargé pour lancer l'installation.
#

color_reset=$'\033[0m'
ressources_folder=$'Balatro_Localization_Resources'

# Initialisation
init() {
echo "========================================="
echo "==     Balatro Turkish Translations    =="
echo "==     TR Dil paketinin yüklenmesi     =="
echo "==        Çeviriler ve resimler        =="
echo "========================================="

    # Kullanıcı sorusu: Türkçe resimler kullanılmalı mı? ?
    echo ""
    echo ""
    echo "Görselleri Türkçe olarak mı kullanmak istiyorsunuz? (Y/N)"
    read -r download_assets

    if [[ "$download_assets" =~ ^[Yy]$ ]]; then
        echo "Les images seront ajoutées."
    elif [[ "$download_assets" =~ ^[Nn]$ ]]; then
        echo "Les images ne seront pas ajoutées."
    else
        download_assets="N"
        echo "Entrée non valide, les images ne seront pas ajoutées."
    fi
}

# Téléchargement de Balamod
download_balamod() {
    echo ""
    echo "Téléchargement de Balamod..."
    echo ""
    # On obtient les données de la dernière release via l'API Github.
    json_latest_release=$(curl -s "https://api.github.com/repos/balamod/balamod/releases/latest")

    # Recherche du nom de la dernière release.
    latest_release=$( echo $json_latest_release | grep -oP 'tag/\K[^"]+')

    # Recherche du nom du fichier linux dans la dernière release (valable tant que UwUDev laisse linux dans le nom du fichier).
    balamod_linux_file=$( echo $json_latest_release | jq -r '.assets[] | select(.name | contains("linux")).name')

    # URL de téléchargement du fichier.
    linux_file_url="https://github.com/balamod/balamod/releases/download/${latest_release}/${balamod_linux_file}"

    # Téléchargement si Balamod n'existe pas
    if [ ! -e "${ressources_folder}/${balamod_linux_file}" ]; then
        curl --create-dirs -o "${ressources_folder}/${balamod_linux_file}" -LJ "${linux_file_url}"
        chmod +x "${ressources_folder}/${balamod_linux_file}"
        echo ""
        echo "Téléchargement de Balamod terminé."
        echo ""
    fi
}

# Téléchargement du pack de langue FR
download_mod_fr() {
    echo ""
    echo "Téléchargement du mod tr..."
    echo ""

    tr_repository="https://raw.githubusercontent.com/FrBmt-BIGetNouf/balatro-french-translations/main/localization"
    tr_translation="${tr_repository}/tr.lua"
    tr_assets_boosters_1x="${tr_repository}/assets/1x/boosters.png"
    tr_assets_boosters_2x="${tr_repository}/assets/2x/boosters.png"
    tr_assets_tarots_1x="${tr_repository}/assets/1x/Tarots.png"
    tr_assets_tarots_2x="${tr_repository}/assets/2x/Tarots.png"
    tr_assets_vouchers_1x="${tr_repository}/assets/1x/Vouchers.png"
    tr_assets_vouchers_2x="${tr_repository}/assets/2x/Vouchers.png"
    tr_assets_icons_1x="${tr_repository}/assets/1x/icons.png"
    tr_assets_icons_2x="${tr_repository}/assets/2x/icons.png"
    tr_assets_BlindChips_1x="${tr_repository}/assets/1x/BlindChips.png"
    tr_assets_BlindChips_2x="${tr_repository}/assets/2x/BlindChips.png"
    tr_assets_Jokers_1x="${tr_repository}/assets/1x/Jokers.png"
    tr_assets_Jokers_2x="${tr_repository}/assets/2x/Jokers.png"
    tr_assets_ShopSignAnimation_1x="${tr_repository}/assets/1x/ShopSignAnimation.png"
    tr_assets_ShopSignAnimation_2x="${tr_repository}/assets/2x/ShopSignAnimation.png"
    tr_assets_8BitDeck_1x="${tr_repository}/assets/1x/8BitDeck.png"
    tr_assets_8BitDeck_2x="${tr_repository}/assets/2x/8BitDeck.png"
    tr_assets_8BitDeck_opt2_1x="${tr_repository}/assets/1x/8BitDeck_opt2.png"
    tr_assets_8BitDeck_opt2_2x="${tr_repository}/assets/2x/8BitDeck_opt2.png"
    font_m6x11plus="${tr_repository}/resources/fonts/m6x11plus.ttf"

    curl --create-dirs -o "${ressources_folder}/tr.lua" -LJ "${tr_translation}"
    curl --create-dirs -o "${ressources_folder}/resources/fonts/m6x11plus.ttf" -LJ "${font_m6x11plus}"

    if [[ "$download_assets" =~ ^[Oo]$ ]]; then
        curl --create-dirs -o "${ressources_folder}/assets/1x/boosters.png" -LJ "${tr_assets_boosters_1x}"
        curl --create-dirs -o "${ressources_folder}/assets/2x/boosters.png" -LJ "${tr_assets_boosters_2x}"
        curl --create-dirs -o "${ressources_folder}/assets/1x/Tarots.png" -LJ "${tr_assets_tarots_1x}"
        curl --create-dirs -o "${ressources_folder}/assets/2x/Tarots.png" -LJ "${tr_assets_tarots_2x}"
        curl --create-dirs -o "${ressources_folder}/assets/1x/Vouchers.png" -LJ "${tr_assets_vouchers_1x}"
        curl --create-dirs -o "${ressources_folder}/assets/2x/Vouchers.png" -LJ "${tr_assets_vouchers_2x}"
        curl --create-dirs -o "${ressources_folder}/assets/1x/icons.png" -LJ "${tr_assets_icons_1x}"
        curl --create-dirs -o "${ressources_folder}/assets/2x/icons.png" -LJ "${tr_assets_icons_2x}"
        curl --create-dirs -o "${ressources_folder}/assets/1x/BlindChips.png" -LJ "${tr_assets_BlindChips_1x}"
        curl --create-dirs -o "${ressources_folder}/assets/2x/BlindChips.png" -LJ "${tr_assets_BlindChips_2x}"
        curl --create-dirs -o "${ressources_folder}/assets/1x/Jokers.png" -LJ "${tr_assets_Jokers_1x}"
        curl --create-dirs -o "${ressources_folder}/assets/2x/Jokers.png" -LJ "${tr_assets_Jokers_2x}"
        curl --create-dirs -o "${ressources_folder}/assets/1x/ShopSignAnimation.png" -LJ "${tr_assets_ShopSignAnimation_1x}"
        curl --create-dirs -o "${ressources_folder}/assets/2x/ShopSignAnimation.png" -LJ "${tr_assets_ShopSignAnimation_2x}"
        curl --create-dirs -o "${ressources_folder}/assets/1x/8BitDeck.png" -LJ "${tr_assets_8BitDeck_1x}"
        curl --create-dirs -o "${ressources_folder}/assets/2x/8BitDeck.png" -LJ "${tr_assets_8BitDeck_2x}"
        curl --create-dirs -o "${ressources_folder}/assets/1x/8BitDeck_opt2.png" -LJ "${tr_assets_8BitDeck_opt2_1x}"
        curl --create-dirs -o "${ressources_folder}/assets/2x/8BitDeck_opt2.png" -LJ "${tr_assets_8BitDeck_opt2_2x}"
    fi

    echo ""
    echo "Téléchargement du mod TR terminé."
    echo ""
}

# Injection du pack de langue TR
mod_injection() {
    echo ""
    echo "Installation du pack de langue..."
    echo ""

    ./$ressources_folder/$balamod_linux_file -x -i $ressources_folder/tr.lua -o localization/tr.lua
    ./$ressources_folder/$balamod_linux_file -x -i $ressources_folder/resources/fonts/m6x11plus.ttf -o resources/fonts/m6x11plus.ttf

    if [[ "$download_assets" =~ ^[Oo]$ ]]; then
        ./$ressources_folder/$balamod_linux_file -x -i $ressources_folder/assets/1x/boosters.png -o resources/textures/1x/boosters.png
        ./$ressources_folder/$balamod_linux_file -x -i $ressources_folder/assets/2x/boosters.png -o resources/textures/2x/boosters.png
        ./$ressources_folder/$balamod_linux_file -x -i $ressources_folder/assets/1x/Tarots.png -o resources/textures/1x/Tarots.png
        ./$ressources_folder/$balamod_linux_file -x -i $ressources_folder/assets/2x/Tarots.png -o resources/textures/2x/Tarots.png
        ./$ressources_folder/$balamod_linux_file -x -i $ressources_folder/assets/1x/Vouchers.png -o resources/textures/1x/Vouchers.png
        ./$ressources_folder/$balamod_linux_file -x -i $ressources_folder/assets/2x/Vouchers.png -o resources/textures/2x/Vouchers.png
        ./$ressources_folder/$balamod_linux_file -x -i $ressources_folder/assets/1x/icons.png -o resources/textures/1x/icons.png
        ./$ressources_folder/$balamod_linux_file -x -i $ressources_folder/assets/2x/icons.png -o resources/textures/2x/icons.png
        ./$ressources_folder/$balamod_linux_file -x -i $ressources_folder/assets/1x/BlindChips.png -o resources/textures/1x/BlindChips.png
        ./$ressources_folder/$balamod_linux_file -x -i $ressources_folder/assets/2x/BlindChips.png -o resources/textures/2x/BlindChips.png
        ./$ressources_folder/$balamod_linux_file -x -i $ressources_folder/assets/1x/Jokers.png -o resources/textures/1x/Jokers.png
        ./$ressources_folder/$balamod_linux_file -x -i $ressources_folder/assets/2x/Jokers.png -o resources/textures/2x/Jokers.png
        ./$ressources_folder/$balamod_linux_file -x -i $ressources_folder/assets/1x/ShopSignAnimation.png -o resources/textures/1x/ShopSignAnimation.png
        ./$ressources_folder/$balamod_linux_file -x -i $ressources_folder/assets/2x/ShopSignAnimation.png -o resources/textures/2x/ShopSignAnimation.png
        ./$ressources_folder/$balamod_linux_file -x -i $ressources_folder/assets/1x/8BitDeck.png -o resources/textures/1x/8BitDeck.png
        ./$ressources_folder/$balamod_linux_file -x -i $ressources_folder/assets/2x/8BitDeck.png -o resources/textures/2x/8BitDeck.png
        ./$ressources_folder/$balamod_linux_file -x -i $ressources_folder/assets/1x/8BitDeck_opt2.png -o resources/textures/1x/8BitDeck_opt2.png
        ./$ressources_folder/$balamod_linux_file -x -i $ressources_folder/assets/2x/8BitDeck_opt2.png -o resources/textures/2x/8BitDeck_opt2.png
    fi

    echo "${color_reset}"
    echo "Installation du pack de langue terminée."
}

download_cleanup() {
    rm -R $ressources_folder
    echo "Balatro a été mis à jour !"
}

init
download_balamod
download_mod_tr
mod_injection
download_cleanup
