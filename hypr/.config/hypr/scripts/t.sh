#!/usr/bin/env bash

DIR="$HOME/Imagens/selectedWallp"

[ ! -d "$DIR" ] && echo "Diretório não existe: $DIR" && exit 1

img=$(find "$DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | rofi -dmenu -theme "~/.config/rofi/launchers/type-4/style-4.rasi"\
    -p "Wallpaper" \
    -preview 'chafa --size=40x20 "{}"' \
    -preview-window right:60%)

[ -z "$img" ] && exit

# aplica wallpaper
awww img "$img" -o "eDP-1"
awww img "$img" -o "HDMI-A-1"

# aplica cores
#wal -i "$img" -n


