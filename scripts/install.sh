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
stow btop fastfetch fuzzel gtk-3.0 hyprland kitty qt6ct starship waybar weather-app zsh

# 4. Install dependencies
echo "📦 Installing dependencies..."
echo "This may take a few minutes..."

# Define packages
PACKAGES=(
    "hyprland"
    "xdg-desktop-portal-hyprland"
    "hyprpolkitagent"
    "hyprlock"
    "hypridle"
    "hyprpaper"
    "hyprshot"
    "waybar"
    "fuzzel"
    "kitty"
    "swaync"
    "zsh"
    "starship"
    "jq"
    "curl"
    "gnome-keyring"
    "libsecret"
    "gvfs-mtp"
    "glib-networking"
    "polkit-gnome"
    "networkmanager"
    "network-manager-applet"
    "playerctl"
    "pavucontrol"
    "cliphist"
    "solaar"
    "fastfetch"
    "grim"
    "slurp"
    "rofi-wayland"
    "eza"
    "dust"
    "fd"
    "bat"
    "ripgrep"
    "procs"
    "fzf"
    "zoxide"
    "git
    "btop"
)

# Install only missing packages
missing=()
for pkg in "${PACKAGES[@]}"; do
    if ! pacman -Q "$pkg" &> /dev/null; then
        missing+=("$pkg")
    fi
done

if [ ${#missing[@]} -eq 0 ]; then
    echo "✅ All dependencies are already installed."
else
    echo "🔧 Installing missing packages: ${missing[*]}"
    sudo pacman -S --noconfirm "${missing[@]}"
fi

echo "✅ Dependencies installed!"


# 5. Install complete
echo "✅ Installation complete! Reboot or start Hyprland."
