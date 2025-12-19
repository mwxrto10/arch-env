#!/bin/bash
set -e

echo "--- Starte Installation: Project Void ---"

# 1. Multilib & Update
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
sudo pacman -Syu --noconfirm

# 2. Basis-Pakete & Utilities
# Hinzugefügt: swww, grim, slurp, wl-clipboard, swaync (Notifications)
sudo pacman -S --noconfirm \
hyprland waybar rofi-wayland kitty \
thunar thunar-archive-plugin file-roller \
gnome-system-monitor mousepad \
pavucontrol network-manager-applet \
ttf-jetbrains-mono-nerd ttf-liberation noto-fonts-emoji \
polkit-gnome starship \
xdg-desktop-portal-hyprland qt5-wayland qt6-wayland \
pipewire pipewire-pulse wireplumber \
git base-devel \
grim slurp wl-clipboard cliphist

# 3. AUR Helper (yay)
if ! command -v yay &> /dev/null; then
    echo "--- Installiere yay ---"
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi

# 4. AUR Pakete
# swww (besserer Wallpaper Daemon), wlogout (Logout Menu)
yay -S --noconfirm wdisplays bibata-cursor-theme-ice papirus-icon-theme-dark swww wlogout swaync

# 5. Ordnerstruktur
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar
mkdir -p ~/.config/rofi
mkdir -p ~/.config/swaync
mkdir -p ~/.config/wlogout
mkdir -p ~/.config/scripts
mkdir -p ~/wallpaper

# 6. Configs kopieren (Hier musst du sicherstellen, dass die Pfade stimmen)
cp configs/hypr/hyprland.conf ~/.config/hypr/hyprland.conf
cp configs/waybar/config ~/.config/waybar/config
cp configs/waybar/style.css ~/.config/waybar/style.css
cp configs/rofi/config.rasi ~/.config/rofi/config.rasi
cp configs/scripts/toggle_bar.sh ~/.config/scripts/toggle_bar.sh
cp wallpaper/black.png ~/wallpaper/black.png

chmod +x ~/.config/scripts/toggle_bar.sh

echo "--- Installation fertig. Bitte neu starten! ---"