#!/bin/bash

WALLPAPER_DIR="$HOME/.config/wallpaper/"
THUMBNAIL_DIR="$HOME/.cache/thumbnails/"
CACHE_PATH="$HOME/.cache/wallpaper/wallpaper.*"
RASI_THEME="$HOME/.config/rofi/wallpaper.rasi"
ROFI_CONFIG="$HOME/.config/rofi/config.rasi"
WALLPAPER_CONFIG="$HOME/.config/rofi/wallpaper.rasi"
DUNST_CONFIG="$HOME/.config/dunst/dunstrc"

list_images() {
    for img in "$WALLPAPER_DIR"*; do
        filename=$(basename "$img")

        thumb="$THUMBNAIL_DIR$filename"

        if [ ! -f "$thumb" ]; then
            magick "$img" -thumbnail 300x "$thumb" &
        fi

        echo -en "$filename\0icon\x1f$thumb\n"
    done
    wait
}

if [ ! -d "$THUMBNAIL_DIR=" ]; then
  mkdir "$THUMBNAIL_DIR"
fi

selected=$(list_images | rofi -dmenu -i -p ">" -theme "$RASI_THEME")

[[ -z "$selected" ]] && exit

FULL_PATH="$WALLPAPER_DIR/$selected"

awww img "$FULL_PATH" --transition-type grow --transition-duration 1.5 --transition-fps 120

wallust pywal -i "$FULL_PATH" -n -q 
mkdir -p "$(dirname "$CACHE_PATH")"
ln -sf "$FULL_PATH" "$CACHE_PATH"

if [ -f "$HOME/.cache/wallust/colors.sh" ]; then
    source "$HOME/.cache/wallust/colors.sh"
    sed -i \
        -e "s/border-color:[[:space:]]*#[A-Fa-f0-9]*/border-color: $color2/g" \
        -e "s/text-color:[[:space:]]*#[A-Fa-f0-9]*/text-color: $color2/g" \
        -e "s/normal-foreground:[[:space:]]*#[A-Fa-f0-9]*/normal-foreground: $color2/g" \
        -e "s/prompt-foreground:[[:space:]]*#[A-Fa-f0-9]*/prompt-foreground: $color2/g" \
        -e "s/selected-normal-background:[[:space:]]*#[A-Fa-f0-9]*/selected-normal-background: $color2/g" \
        -e "s/selected-normal-foreground:[[:space:]]*#[A-Fa-f0-9]*/selected-normal-foreground: #000000/g" \
        "$ROFI_CONFIG"
    sed -i \
        -e "s/text-color:[[:space:]]*#[A-Fa-f0-9]*/text-color: $color2/g" \
        -e "s/border-color:[[:space:]]*#[A-Fa-f0-9]*/border-color: $color2/g" \
        "$WALLPAPER_CONFIG"
fi

kill -SIGUSR1 $(pgrep kitty) 2>/dev/null
killall dunst
dunst &

sleep 0.1
notify-send "theme" "updated"
