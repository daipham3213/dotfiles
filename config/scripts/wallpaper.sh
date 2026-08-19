#!/bin/bash

WALLPAPER_DIR="$HOME/.config/wallpaper/"
THUMBNAIL_DIR="$HOME/.cache/thumbnails/"
CACHE_PATH="$HOME/.cache/wallpaper/wallpaper.*"
RASI_THEME="$HOME/.config/rofi/wallpaper.rasi"

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

if [ ! -d "$THUMBNAIL_DIR" ]; then
  mkdir -p "$THUMBNAIL_DIR"
fi

selected=$(list_images | rofi -dmenu -i -p ">" -theme "$RASI_THEME")

[[ -z "$selected" ]] && exit

FULL_PATH="$WALLPAPER_DIR/$selected"

awww img "$FULL_PATH" --transition-type grow --transition-duration 1.5 --transition-fps 120

matugen image "$FULL_PATH" --prefer saturation -b wal -q

mkdir -p "$(dirname "$CACHE_PATH")"
ln -sf "$FULL_PATH" "$CACHE_PATH"

sleep 0.1
notify-send "theme" "updated"
