#!/bin/bash
set -e

# 1. Multilib aktivieren (für Steam Vorbereitung) & Update
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
sudo pacman -Syu --noconfirm

# 2. Basis-Pakete (Ohne AUR Tools, Ohne Steam)
sudo pacman -S --noconfirm \
hyprland waybar rofi-wayland kitty \
thunar thunar-archive-plugin file-roller \
gnome-system-monitor mousepad \
pavucontrol network-manager-applet \
ttf-jetbrains-mono-nerd ttf-liberation noto-fonts-emoji \
polkit-gnome starship \
xdg-desktop-portal-hyprland qt5-wayland qt6-wayland \
pipewire pipewire-pulse wireplumber \
git base-devel

# 3. AUR Helper (yay) installieren
if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi

# 4. AUR Pakete (Themes & Monitor Tool)
yay -S --noconfirm wdisplays bibata-cursor-theme-ice papirus-icon-theme-dark

# 5. Config Ordner erstellen
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar
mkdir -p ~/.config/rofi
mkdir -p ~/.config/scripts
mkdir -p ~/wallpaper

# 6. Configs kopieren
cp configs/hypr/hyprland.conf ~/.config/hypr/hyprland.conf
cp configs/waybar/config ~/.config/waybar/config
cp configs/waybar/style.css ~/.config/waybar/style.css
cp configs/rofi/config.rasi ~/.config/rofi/config.rasi
cp configs/scripts/toggle_bar.sh ~/.config/scripts/toggle_bar.sh
cp wallpaper/black.png ~/wallpaper/black.png

chmod +x ~/.config/scripts/toggle_bar.sh

echo "Fertig. Starte neu oder tippe 'Hyprland'."