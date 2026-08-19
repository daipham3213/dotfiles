#!/bin/bash

HYPR_CONF="$HOME/.config/hypr/hyprland.lua"
options="fade\nvertical\nhorizontal"

choice=$(echo -e "$options" | rofi -dmenu -i -p ">")

[[ -z "$choice" ]] && exit

case "$choice" in
    fade)
        sed -i '/@dynamic_workspaces/c\hl.animation({ leaf = "workspaces",       enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" }) -- @dynamic_workspaces' "$HYPR_CONF"
        sed -i '/@dynamic_special/c\hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" }) -- @dynamic_special' "$HYPR_CONF"
        hyprctl keyword animation "workspaces, 1, 1, almostLinear, fade"
        hyprctl keyword animation "specialWorkspace, 1, 1, almostLinear, fade"
        notify-send "animations" "fade"
        ;;
    vertical)
        sed -i '/@dynamic_workspaces/c\hl.animation({ leaf = "workspaces",       enabled = true, speed = 5, bezier = "hard", style = "slidevert" }) -- @dynamic_workspaces' "$HYPR_CONF"
        sed -i '/@dynamic_special/c\hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 5, bezier = "hard", style = "slidevert" }) -- @dynamic_special' "$HYPR_CONF"
        hyprctl keyword animation "workspaces, 1, 5, hard, slidevert"
        hyprctl keyword animation "specialWorkspace, 1, 5, hard, slidevert"
        notify-send "animations" "vertical"
        ;;
    horizontal)
        sed -i '/@dynamic_workspaces/c\hl.animation({ leaf = "workspaces",       enabled = true, speed = 5, bezier = "hard", style = "slide" }) -- @dynamic_workspaces' "$HYPR_CONF"
        sed -i '/@dynamic_special/c\hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 5, bezier = "hard", style = "slide" }) -- @dynamic_special' "$HYPR_CONF"
        hyprctl keyword animation "workspaces, 1, 5, hard, slide"
        hyprctl keyword animation "specialWorkspace, 1, 5, hard, slide"
        notify-send "animations" "horizontal"
        ;;
esac
