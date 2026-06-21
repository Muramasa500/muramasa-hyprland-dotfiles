#!/bin/bash
# ~/.config/hypr/show-shortcuts.sh
cat << 'EOF' | wofi --show dmenu \
    --width 660 \
    --height 1080 \
    --allow-markup \
    --prompt="⌨️ Type to filter..." \
    --font "JetBrains Mono:size=13" \
    --css ~/.config/wofi/style-shortcuts-simple.css
<b>══════════════════════════ 󰌌 HYPRLAND KEYBINDINGS ═════════════════════════════</b>
<span foreground="#a6e3a1"><b>━━━━━━━━━━━━━━━━━━━━═━━━━━━━━━━━  󰣆 APPS  ━━━━━━━━━━━━━━═━━━━━━━━━━━━━━━━━━━━━━</b></span>
<b>SUPER + Q     </b> → Kitty Terminal         <b>SUPER + E     </b> → Dolphin Manager
<b>SUPER + SPCE  </b> → HyprLauncher           <b>SUPER + F     </b> → Firefox Browser
<b>SUPER + S     </b> → Spotify                <b>SUPER + K     </b> → Kate
<b>SUPER + N     </b> → Neovim                 <b>SUPER + P     </b> → Proton VPN
<b>SUPER + O     </b> → Proton Pass            <b>SUPER + M     </b> → Proton Mail
<b>SUPER + B     </b> → Qbittorrent            <b>SUPER + T     </b> → Qalculate

<span foreground="#a6e3a1"><b>━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 󰶭  WINDOWS  ━━━━━━━━━━━━━━━━━━━═━━━━━━━━━━━━━━━</b></span>
<b>SUPER + C     </b> → Close Window           <b>SUPER + V     </b> → Toggle Float
<b>SUPER + L     </b> → Lock Screen            <b>SUPER + H     </b> → Show Shortcuts

<span foreground="#a6e3a1"><b>━━━━━━━━━━━━━━━━━━═━━━━━━━━━   MOVE WINDOWS  ━━━━━━━━━━━═━━━━━━━━━━━━━━━━━━━━━</b></span>
<b>SUP+SHIFT+[n] </b> → Move Win to WS[n]      <b>SUP+SHIFT+→   </b> → Move Win to Next WS
<b>SUP+ALT+SHIFT+←</b> → Move WS to Prev Mon    <b>SUP+ALT+SHIFT+→</b> → Move WS to Next Mon

<span foreground="#a6e3a1"><b>━━━━━━━━━━━━━━━━━━━━━━━━━━━ 󰍺 SWITCH WORKSPACES  ━━━━━━━━━━━━━━═━━━━━━━━━━━━━━━</b></span>
<b>SUPER + [1-9] </b> → Switch Workspace         <b>SUPER + 0     </b> → Workspace 10
<b>SUPER + ←     </b> → Focus Left             <b>SUPER + →     </b> → Focus Right
<b>SUPER + ↑     </b> → Focus Up               <b>SUPER + ↓     </b> → Focus Down

# # <span foreground="#a6e3a1"><b>━━━━━━━━━━━━━━━━═━━━━━━━━━━━ 󰎐 NAVIGATION  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━</b></span>
<b>SUP+ALT+←     </b> → Swap Win Left            <b>SUP+ALT+→     </b> → Swap Win Right
<b>SUP+ALT+↑     </b> → Swap Win Up              <b>SUP+ALT+↓     </b> → Swap Win Down
<b>SUP+ALT+Left  </b> → Win to Prev Mon          <b>SUP+ALT+Right </b> → Win to Next Mon

<span foreground="#a6e3a1"><b>━━━━━━━━━━━━━━━━━━━═━━━━━━━━ 󰹑 SCREENSHOTS  ━━━━━━━━━━━━━━━═━━━━━━━━━━━━━━━━━━━</b></span>
<b>PRINT         </b> → Fullscreen (File)        <b>SUPER+PRINT   </b> → Active Window (File)
<b>CTRL+PRINT    </b> → Region (Clipboard)       <b>SUP+SHIFT+P   </b> → Region (File)

<span foreground="#a6e3a1"><b>━━━━━━━━━━━━━━━═━━━━━━━━   EDIT CONFIG / RELOAD  ━━━━━━━═━━━━━━━━━━━━━━━━━━━━━</b></span>
<b>SUPER + Z     </b> → hyprland.lua            <b>SUPER + SHIFT + Z</b> → hypr-shortcuts.lua
<b>SUPER + X     </b> → waybar: config.jsonc    <b>SUPER + SHIFT + Z</b> → waybar: style.css
<b>SUPER + 9     </b> → Reload Hyprland         <b>SUPER + 8    </b> → Waybar: Kill + start
<b>SUPER + SHIFT + 8   </b> → waybar: start

<big><i>Type to filter... | Press ESC to close</i></big>
EOF
