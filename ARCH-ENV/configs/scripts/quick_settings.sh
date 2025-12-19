#!/usr/bin/env bash

# Optionen
OPTIONS="1920x1080\n1280x720\nReboot\nShutdown"

# Rofi Auswahl
CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -p "Settings" -theme ~/.config/rofi/config.rasi)

case "$CHOICE" in
    "1920x1080")
        xrandr --output Virtual1 --mode 1920x1080
        ;;
    "1280x720")
        xrandr --output Virtual1 --mode 1280x720
        ;;
    "Reboot")
        reboot
        ;;
    "Shutdown")
        poweroff
        ;;
esac