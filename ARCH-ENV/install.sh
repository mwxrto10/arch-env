#!/bin/bash

# Farben für Output
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}>>> Starte Installation des Pitch Black Architect Desktops...${NC}"

# 1. Update & Pakete installieren
echo -e "${GREEN}>>> Installiere Pakete (i3, polybar, rofi, alacritty, tools)...${NC}"
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm \
    xorg-server xorg-xinit \
    i3-gaps \
    polybar \
    rofi \
    alacritty \
    feh \
    picom \
    jq \
    git \
    ttf-jetbrains-mono-nerd \
    virtualbox-guest-utils \
    xorg-xrandr

# 2. VirtualBox Services aktivieren
echo -e "${GREEN}>>> Aktiviere VirtualBox Guest Services...${NC}"
sudo systemctl enable --now vboxservice

# 3. Ordnerstruktur erstellen
echo -e "${GREEN}>>> Erstelle Konfigurationsordner...${NC}"
mkdir -p ~/.config/i3
mkdir -p ~/.config/polybar
mkdir -p ~/.config/picom
mkdir -p ~/.config/rofi
mkdir -p ~/.config/scripts
mkdir -p ~/wallpaper

# 4. Configs kopieren
echo -e "${GREEN}>>> Kopiere Config-Dateien...${NC}"
# Wir gehen davon aus, dass das Skript im Root des Repos ausgeführt wird
cp configs/i3/config ~/.config/i3/config
cp configs/polybar/config.ini ~/.config/polybar/config.ini
cp configs/polybar/launch.sh ~/.config/polybar/launch.sh
cp configs/picom/picom.conf ~/.config/picom/picom.conf
cp configs/rofi/config.rasi ~/.config/rofi/config.rasi
cp configs/scripts/*.sh ~/.config/scripts/

# Dummy Wallpaper erstellen, falls nicht vorhanden (oder kopiere dein eigenes)
# convert -size 1920x1080 xc:black ~/wallpaper/black.png (Benötigt imagemagick, hier workaround:)
cp wallpaper/black.png ~/wallpaper/black.png 2>/dev/null || echo "Warnung: black.png nicht gefunden."

# 5. Skripte ausführbar machen
chmod +x ~/.config/polybar/launch.sh
chmod +x ~/.config/scripts/*.sh

# 6. xinitrc einrichten (Damit 'startx' i3 startet)
echo "exec i3" > ~/.xinitrc

echo -e "${GREEN}>>> Installation abgeschlossen! Tippe 'startx' um zu starten.${NC}"