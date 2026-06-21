#!/bin/bash
CONFIG="$HOME/.config/hypr/hyprland.lua"

# Read current layout
CURRENT_LAYOUT=$(grep -oP 'layout\s*=\s*"\K[^"]+' "$CONFIG" | head -n 1)

if [ "$CURRENT_LAYOUT" == "dwindle" ]; then
    NEW_LAYOUT="master"
    echo "Switching to Master Layout..."
else
    NEW_LAYOUT="dwindle"
    echo "Switching to Dwindle Layout..."
fi

# Backup first (optional but safe)
cp "$CONFIG" "${CONFIG}.bak"

# Replace the layout line
# Note: This assumes the line looks like: layout = "dwindle"
sed -i "s/layout\s*=\s*\"dwindle\"/layout = \"$NEW_LAYOUT\"/g" "$CONFIG"
sed -i "s/layout\s*=\s*\"master\"/layout = \"$NEW_LAYOUT\"/g" "$CONFIG"

# Reload Hyprland
sleep 0.5
hyprctl reload

# Notify (optional, uses swaync if installed)
notify-send "Layout Changed" "Now using: $NEW_LAYOUT" -u low
