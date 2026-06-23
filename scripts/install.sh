#!/bin/bash
# Installation script

echo "🚀 Installing Muramasa's Hyprland Dotfiles..."

# 1. Install Stow if missing (Arch)
if ! command -v stow &> /dev/null; then
    echo "📦 Installing GNU Stow..."
    sudo pacman -S --noconfirm stow
fi

# 2. Create backup of existing configs
echo "⚠️ Warning: This will overwrite existing configs in ~/.config"
read -p "Proceed? (y/n): " confirm
[[ $confirm == "y" ]] || exit 1

# 3. Symlink directories using Stow
cd "$(dirname "$0")"
stow fastfetch fuzzel gtk-3.0 hyprland kitty qt6ct starship waybar weather-app zsh

echo "✅ Installation complete! Reboot or start Hyprland."
