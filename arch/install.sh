#!/bin/bash

# Pakete installieren
sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm base-devel git hyprland waybar kitty wofi dunst pipewire pipewire-pulse wireplumber polkit-gnome xdg-desktop-portal-hyprland qt5-wayland qt6-wayland brightnessctl pamixer network-manager-applet btop hyprpaper ttf-jetbrains-mono-nerd noto-fonts-emoji firefox thunar grim slurp

# Ordner erstellen
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar
mkdir -p ~/.config/kitty
mkdir -p ~/.config/wofi

# Configs kopieren
cp -r hypr/* ~/.config/hypr/
cp -r waybar/* ~/.config/waybar/
cp -r kitty/* ~/.config/kitty/
cp -r wofi/* ~/.config/wofi/

# Berechtigungen setzen
chmod +x ~/.config/hypr/hyprland.conf
chmod +x ~/.config/waybar/config

echo "Installation abgeschlossen. reboot."