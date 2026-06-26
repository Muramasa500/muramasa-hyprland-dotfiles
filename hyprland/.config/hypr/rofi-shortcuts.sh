#!/bin/bash

shortcuts="SUPER + Q → Kitty Terminal
SUPER + E → Open File Manager
SUPER + C → Close Window
SUPER + F → Open Firefox
SUPER + H → Show Shortcuts
SUPER + T → Open Calculator
SUPER + N → Open Neovim
SUPER + Z → Open Zed
SUPER + S → Open Spotify
SUPER + Space → Open Application Menu
SUPER + L → Screen Locker
SUPER + V → Toggle Float
SUPER + Tab → Window Switcher
SUPER + SHIFT + R → Reload Hyprland
SUPER + ALT + R → Restart Waybar
SUPER + Left/Right/Up/Down → Focus Window
SUPER + SHIFT + Left/Right → Move Window
SUPER + ALT + Left/Right/Up/Down → Swap Window
SUPER + CTRL + P → Screenshot (Full)
SUPER + SHIFT + P → Screenshot (Select)
SUPER + ALT + P → Screenshot & Upload"

echo "$shortcuts" | rofi -dmenu -i -p " Shortcuts" -mesg "Hyprland Keybindings" -no-custom -kb-cancel "Escape" -theme-str 'window { width: 600px; }'
