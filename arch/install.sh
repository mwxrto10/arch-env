#!/bin/bash

# Stop script on error (removed for the package install part to handle errors gracefully)
# set -e 

echo "--- 🟣 Project Void Installer ---"

# 0. Sync Keys & Repos (Fixes 'target not found' issues)
echo ":: Updating Keyring..."
sudo pacman -Sy --noconfirm archlinux-keyring
sudo pacman -Syu --noconfirm

# 1. Enable Multilib
echo ":: Enabling Multilib..."
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
sudo pacman -Sy --noconfirm

# 2. Install Core Packages (Split to prevent one failure stopping everything)
echo ":: Installing Core Hyprland Packages..."
sudo pacman -S --noconfirm \
hyprland waybar rofi-wayland kitty \
polkit-gnome starship \
xdg-desktop-portal-hyprland qt5-wayland qt6-wayland \
git base-devel

echo ":: Installing File Management & Tools..."
sudo pacman -S --noconfirm \
thunar thunar-archive-plugin file-roller gvfs \
btop mousepad grim slurp wl-clipboard cliphist

echo ":: Installing Audio & Network..."
sudo pacman -S --noconfirm \
pipewire pipewire-pulse wireplumber pavucontrol \
networkmanager bluez bluez-utils

echo ":: Installing Fonts & Theming..."
# We try to install arc-gtk-theme, but if it fails, we continue
sudo pacman -S --noconfirm ttf-jetbrains-mono-nerd ttf-font-awesome papirus-icon-theme arc-gtk-theme || echo ":: Warning: arc-gtk-theme failed via pacman (will try yay later)"

# 3. Setup AUR Helper (Yay)
if ! command -v yay &> /dev/null; then
    echo ":: Installing Yay..."
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi

# 4. Install AUR Packages & Missing Themes
echo ":: Installing AUR Packages..."
# Added nwg-look and backup theme source
yay -S --noconfirm swww wlogout swaync wdisplays bibata-cursor-theme-ice nwg-look

# If arc-gtk-theme failed earlier, try AUR version or standard
if ! pacman -Qi arc-gtk-theme &> /dev/null; then
    yay -S --noconfirm arc-gtk-theme
fi

# 5. Enable Services
echo ":: Enabling Services..."
sudo systemctl enable --now NetworkManager
sudo systemctl enable --now bluetooth

# 6. Create Directories
echo ":: Setting up Configs..."
rm -rf ~/.config/hypr ~/.config/waybar ~/.config/rofi ~/.config/kitty
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar
mkdir -p ~/.config/rofi
mkdir -p ~/.config/kitty
mkdir -p ~/.config/scripts
mkdir -p ~/wallpaper

# 7. Copy Configs (Fixed Case Sensitivity for Wallpaper)
cp configs/hypr/hyprland.conf ~/.config/hypr/hyprland.conf
cp configs/waybar/config ~/.config/waybar/config
cp configs/waybar/style.css ~/.config/waybar/style.css
cp configs/rofi/config.rasi ~/.config/rofi/config.rasi
cp configs/scripts/toggle_bar.sh ~/.config/scripts/toggle_bar.sh
cp configs/kitty/kitty.conf ~/.config/kitty/kitty.conf

# ERROR FIX: Copy from 'Wallpaper' (Capital) to '~/wallpaper' (Lowercase)
if [ -f "Wallpaper/black.png" ]; then
    cp Wallpaper/black.png ~/wallpaper/black.png
else
    echo "!! Warning: Wallpaper/black.png not found. Check folder name."
fi

# 8. Set Permissions
chmod +x ~/.config/scripts/toggle_bar.sh

echo "--- ✅ Installation Done! ---"
echo "Type 'Hyprland' to start."