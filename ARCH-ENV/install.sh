#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}>>> Installing Pitch Black Desktop...${NC}"

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm \
    xorg-server xorg-xinit \
    i3-wm \
    polybar \
    rofi \
    alacritty \
    feh \
    picom \
    jq \
    git \
    ttf-jetbrains-mono-nerd \
    virtualbox-guest-utils \
    xorg-xrandr \
    steam \
    firefox \
    pavucontrol \
    networkmanager-applet \
    brightnessctl

sudo systemctl enable --now vboxservice

mkdir -p ~/.config/i3
mkdir -p ~/.config/polybar
mkdir -p ~/.config/picom
mkdir -p ~/.config/rofi
mkdir -p ~/.config/scripts
mkdir -p ~/wallpaper

cp configs/i3/config ~/.config/i3/config
cp configs/polybar/config.ini ~/.config/polybar/config.ini
cp configs/polybar/launch.sh ~/.config/polybar/launch.sh
cp configs/picom/picom.conf ~/.config/picom/picom.conf
cp configs/rofi/config.rasi ~/.config/rofi/config.rasi
cp configs/scripts/*.sh ~/.config/scripts/

cp wallpaper/black.png ~/wallpaper/black.png 2>/dev/null || \
    convert -size 1920x1080 xc:black ~/wallpaper/black.png 2>/dev/null || \
    echo -e "\x1b[31mWarning: Could not create wallpaper. Please install imagemagick or provide black.png\x1b[0m"

chmod +x ~/.config/polybar/launch.sh
chmod +x ~/.config/scripts/*.sh

echo "exec i3" > ~/.xinitrc

echo -e "${GREEN}>>> Installation complete! Type 'startx' to begin.${NC}"