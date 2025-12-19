#!/bin/bash
set -e

echo "--- 🟣 Project Void Installer ---"

# 1. System Update & Multilib
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
sudo pacman -Syu --noconfirm

# 2. Treiber & Basis (Hyprland, Waybar, Audio, Fonts)
sudo pacman -S --noconfirm \
hyprland waybar rofi-wayland kitty \
thunar thunar-archive-plugin file-roller \
btop mousepad \
pavucontrol networkmanager \
ttf-jetbrains-mono-nerd ttf-font-awesome \
polkit-gnome starship \
xdg-desktop-portal-hyprland qt5-wayland qt6-wayland \
pipewire pipewire-pulse wireplumber \
arc-gtk-theme papirus-icon-theme \
git base-devel \
grim slurp wl-clipboard cliphist

# 3. AUR Helper (yay)
if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi

# 4. AUR Tools (Wallpaper, Logout, Displays)
yay -S --noconfirm swww wlogout swaync wdisplays bibata-cursor-theme-ice

# 5. Ordnerstruktur bereinigen & erstellen
rm -rf ~/.config/hypr ~/.config/waybar ~/.config/rofi ~/.config/kitty
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar
mkdir -p ~/.config/rofi
mkdir -p ~/.config/kitty
mkdir -p ~/.config/scripts
mkdir -p ~/wallpaper

# 6. Configs kopieren
cp configs/hypr/hyprland.conf ~/.config/hypr/hyprland.conf
cp configs/waybar/config ~/.config/waybar/config
cp configs/waybar/style.css ~/.config/waybar/style.css
cp configs/rofi/config.rasi ~/.config/rofi/config.rasi
cp configs/scripts/toggle_bar.sh ~/.config/scripts/toggle_bar.sh
cp configs/kitty/kitty.conf ~/.config/kitty/kitty.conf
cp wallpaper/black.png ~/wallpaper/black.png

chmod +x ~/.config/scripts/toggle_bar.sh

echo "Done! input Hyprland"