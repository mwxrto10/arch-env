#!/bin/bash
set -e

echo ">>> Aktiviere Multilib & Update..."
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
sudo pacman -Syu --noconfirm

echo ">>> Installiere Basispakete, Hyprland, Audio, Tools..."
sudo pacman -S --noconfirm \
hyprland waybar rofi-wayland kitty \
thunar thunar-archive-plugin file-roller \
gnome-system-monitor mousepad \
pavucontrol network-manager-applet \
ttf-jetbrains-mono-nerd ttf-liberation noto-fonts-emoji \
polkit-gnome starship \
steam wdisplays \
xdg-desktop-portal-hyprland qt5-wayland qt6-wayland \
pipewire pipewire-pulse wireplumber \
git base-devel

echo ">>> Installiere AUR Helper (yay) für Themes..."
if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi

echo ">>> Installiere Icons & Cursor..."
yay -S --noconfirm bibata-cursor-theme-ice papirus-icon-theme-dark

echo ">>> Konfiguriere Ordner..."
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar
mkdir -p ~/.config/rofi
mkdir -p ~/.config/scripts
mkdir -p ~/wallpaper
mkdir -p ~/Pictures/Screenshots

echo ">>> Kopiere Configs..."
cp configs/hypr/hyprland.conf ~/.config/hypr/hyprland.conf
cp configs/waybar/config ~/.config/waybar/config
cp configs/waybar/style.css ~/.config/waybar/style.css
cp configs/rofi/config.rasi ~/.config/rofi/config.rasi
cp configs/scripts/toggle_bar.sh ~/.config/scripts/toggle_bar.sh
cp wallpaper/black.png ~/wallpaper/black.png

chmod +x ~/.config/scripts/toggle_bar.sh

echo ">>> Setup fertig. Tippe 'Hyprland' zum Starten."