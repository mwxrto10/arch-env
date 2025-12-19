#!/usr/bin/env bash

OPTIONS="Display: 1920x1080\nDisplay: 1280x720\nAudio: Mute\nAudio: Unmute\nPower: Reboot\nPower: Shutdown\nBrightness: 100%\nBrightness: 50%\nBrightness: 10%"

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -p "Quick Settings" -theme ~/.config/rofi/config.rasi)

case "$CHOICE" in
    "Display: 1920x1080")
        xrandr --output Virtual1 --mode 1920x1080
        ;;
    "Display: 1280x720")
        xrandr --output Virtual1 --mode 1280x720
        ;;
    "Audio: Mute")
        pactl set-sink-mute @DEFAULT_SINK@ true
        ;;
    "Audio: Unmute")
        pactl set-sink-mute @DEFAULT_SINK@ false
        ;;
    "Power: Reboot")
        reboot
        ;;
    "Power: Shutdown")
        poweroff
        ;;
    "Brightness: 100%")
        brightnessctl set 100%
        ;;
    "Brightness: 50%")
        brightnessctl set 50%
        ;;
    "Brightness: 10%")
        brightnessctl set 10%
        ;;
esac