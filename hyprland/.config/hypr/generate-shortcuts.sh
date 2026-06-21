#!/bin/bash
# ~/.config/hypr/generate-shortcuts.sh

CONFIG_FILE="$HOME/.config/hypr/hypr-shortcuts.lua"
FUELZEL_FONT="JetBrains Mono:size=13"

# Check if config exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: $CONFIG_FILE not found!" >&2
    exit 1
fi

# Start Fuzzel
cat << 'EOF' | fuzzel --dmenu \
    --font "$FUELZEL_FONT" \
    --width 650 \
    --lines 25 \
    --border-radius 12 \
    --pad 15 \
    --prompt "⌨️  Keybindings (Parsed from Lua)" \
    --match-mode fzf \
    --show-matched-entries-only

 ════════ HYPRLAND KEYBINDINGS ════════
(Generated from $(basename $CONFIG_FILE))
EOF


awk '
BEGIN {
    print ""
    category = ""
}

# Detect categories based on comments in your lua file
/PROGRAMS.*Variables/ { category = "APP LAUNCHERS"; next }
/WORKSPACE/ { category = "WORKSPACES"; next }
/SCREENSHOTS/ { category = "SCREENSHOTS"; next }
/MOVE|SWAP|FOCUS/ { if (category != "APP LAUNCHERS") category = "WINDOW MANAGEMENT"; next }

# Match standard program launches: hl.bind("MOD + K", hl.dsp.exec_cmd("cmd"))
/\bhl\.bind\(/ && /hl\.dsp\.exec_cmd/ {
    # Extract the key combination (remove quotes and spaces around +)
    match($0, /"\s*([^"]+)\s*"/, key_arr);
    key = key_arr[1];

    # Remove extra spaces around operators for cleaner display
    gsub(/ +\+ +/, " + ", key);

    # Extract the command
    match($0, /exec_cmd\(([^)]+)\)/, cmd_arr);
    cmd = cmd_arr[1];

    # Clean up command string (remove quotes, simplify path)
    gsub(/"/, "", cmd);
    gsub(/~\/\.$/ || /\/home\/mlj\//, "~/", cmd); # Simplify paths if desired

    # Specific formatting logic to make it readable
    desc = cmd;
    if (cmd ~ /kitty/) desc = "Kitty Terminal";
    else if (cmd ~ /dolphin/) desc = "Dolphin";
    else if (cmd ~ /firefox/) desc = "Firefox";
    else if (cmd ~ /hyprlauncher|menu/) desc = "HyprLauncher";
    else if (cmd ~ /hyprlock/) desc = "Lock Screen";
    else if (cmd ~ /vlance|vpn/) desc = "Proton VPN";
    else if (cmd ~ /show-shortcuts/) desc = "Show Shortcuts";

    printf "%-15s → %s\n", key, desc
}

# Match window focus/move: hl.bind(..., hl.dsp.focus({...}))
/\bhl\.bind\(/ && /hl\.dsp\.focus/ {
    match($0, /"\s*([^"]+)\s*"/, key_arr);
    key = key_arr[1];
    gsub(/ +\+ +/, " + ", key);

    desc = "";
    if ($0 ~ /direction.*l/) desc = "Focus Left";
    else if ($0 ~ /direction.*r/) desc = "Focus Right";
    else if ($0 ~ /direction.*u/) desc = "Focus Up";
    else if ($0 ~ /direction.*d/) desc = "Focus Down";
    else if ($0 ~ /workspace.*previous/) desc = "Prev Workspace";
    else if ($0 ~ /workspace.*next/) desc = "Next Workspace";

    if (desc != "") printf "%-15s → %s\n", key, desc
}

/for i = .* hl\.bind\(mainMod.* SHIFT.*tostring/i {
}

END {
    print ""
    print "💡 Tip: Use UP/DOWN arrows to navigate, Enter to copy binding"
}
' "$CONFIG_FILE" | while IFS= read -r line; do
    echo "$line"
done
