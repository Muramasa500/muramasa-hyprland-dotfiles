# Muramasa's Dotfiles

My personal configuration files for **Arch Linux** with **Hyprland** compositor, featuring **Catppuccin Macchiato** theming.

![Status](https://img.shields.io/badge/status-active-success)
![License](https://img.shields.io/badge/license-MIT-blue)
![OS](https://img.shields.io/badge/OS-Arch_Linux-orange)

## Overview

This repository contains my complete desktop environment configuration including:

| Component | Description |
|-----------|-------------|
| **Hyprland** | Tiling Wayland compositor with animations |
| **Waybar** | Status bar with custom modules (weather, clock, system stats) |
| **Fuzzel** | Application launcher & dmenu replacement |
| **Kitty** | GPU-accelerated terminal emulator |
| **Zsh** | Shell with Starship prompt |
| **Catppuccin** | Unified color theme across GTK, Qt, and terminals |

## Screenshots

![Desktop Screenshot](./screenshots/desktop1.png)
![Desktop Screenshot](./screenshots/desktop2.png)

## Directory Structure

```bash
~/dotfiles/
├── fastfetch        # Fastfetch config
├── fuzzel/          # Fuzzel launcher config
├── gtk-3.0/         # gtk config / themes
├── hyprland/        # Hyprland config (hyprland.lua)
├── kitty/           # Kitty terminal config
├── qt6ct/           # qt6 config / themes
├── screenshots/     # Screenshots
├── starship/        # Starship prompt config
├── waybar/          # Waybar config, style.css, scripts
├── weather-app/     # Custom weather script + config
└── zsh/             # .zshrc shell config
```

## Installation

### Option 1: Using GNU Stow (Recommended)

```bash
git clone git@github.com:Muramasa500/muramasa500-hyprland-dotfiles~/	dotfiles
sudo pacman -S stow
cd ~/dotfiles
stow fastfetch fuzzel gtk-3.0 hyprland kitty qt5ct qt6ct starship waybar weather-app zsh
```


### Option 2: Manual Setup
```bash
cp -r fastfetch/.config/* ~/.config/
cp -r fuzzel/.config/* ~/.config/
cp -r gtk-3.0 /.config/* ~/.config/
 ... repeat for other folders
```

--- 

## Key Features

- Weather Display: Open-Meteo API integration with 3-day forecast
- Clipboard Manager: Cliphist integration for history
- Power Menu: Shutdown, reboot, suspend, hibernate, logout
- Multi-Monitor: Optimized for 3 displays
- NVIDIA Support: GTX 1070 drivers configured
- Language Switcher: EN/SE keyboard layout toggle

---


## Important Notes

Files NOT in this repo (ignored):
- weather-app/geolocation (GPS coordinates for weather app)

---

## Keyboard Shortcuts

| Keybinding | Action |
|------------|--------|
| `Super + space` | Open Fuzzel application launcher|
| `Super + Q` | Open kitty terminal |
| `Super + F` | Open firefox browser |
| `Super + Z` | Open Zed editor |
| `Super + N` | Open Neovim editor |
| `Super + Shift + C` | Close focused window |
| `Super + Arrow` | Move focus to a new window |
| `Super + Shift + Arrow` | Move focused window to new workspace |
| `Super + 1 ... 9` | Move to workspace  1 .. 9 |
|------------|--------|

*(Check `~/.config/hypr/hyprland.lua` for full list)*


---

## Post-Clone Configuration

After cloning, you must:
1. Create ~/.config/weather-app/geolocation with your own coordinates.
2. Generate new SSH keys on your machine (ssh-keygen).
3. Set your own wallpapers in ~/.config/hypr/wallpapers/.

---


## Dependencies

Install required packages:

```bash
sudo pacman -S \
  hyprland xdg-desktop-portal-hyprland hyprpolkitagent hyprlock hypridle hyprpaper \
  waybar fuzzel kitty swaync \
  zsh starship jq curl \
  gnome-keyring libsecret \
  gvfs-mtp glib-networking polkit-gnome \
  networkmanager network-manager-applet \
  playerctl pavucontrol cliphist
```

## Contributing

Feel free to fork and modify! I am not accepting PRs back to main, but issues are welcome.

---

## License

MIT License - See LICENSE file for details.

---

ENDOFREADME
