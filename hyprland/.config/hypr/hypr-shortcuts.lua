-- ============================================================
-- ======                 KEYBINDINGS                    ======
-- ============================================================

-- ============================================================
-- ======           PROGRAMS (VARIABLES)                 ======
-- ============================================================

local mainMod = "SUPER"
local terminal = "kitty"
local fileManager = "thunar"
local menu = "~/.config/waybar/apps_menu.sh"
local screenLocker = "hyprlock"
local browser = "firefox"
local calculator = "qalculate-gtk"
local gui_editor = "zeditor"
local cli_editor = "kitty nvim"


-- ============================================================
-- ======            KEYBINDINGS PROGRAMS                ======
-- ============================================================
-- Open programs
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(menu))
local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(screenLocker))
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd("~/.config/hypr/show-shortcuts.sh"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(calculator))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(cli_editor))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd(gui_editor))
-- hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("flatpak run com.spotify.Client"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("spotify-launcher"))


-- Edit coniguration files
-- edit Hyprland: hyprland.lua, hypr-shortcuts.lua. edit Waybar: config.jsonc style.css
hl.bind(mainMod .. " + X",
    hl.dsp.exec_cmd(gui_editor ..
        " + .config/waybar/config.jsonc &&" .. gui_editor .. " + .config/waybar/style.css &&" ..
        gui_editor .. " + ~/.config/hypr/hypr-shortcuts.lua &&" .. gui_editor .. " + ~/.config/hypr/hyprland.lua"))
-- Reload hyprland
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("kitty hyprctl reload"))
-- Reload waybar
hl.bind(mainMod .. " + ALT + R", hl.dsp.exec_cmd("kitty killall waybar && nohup waybar &"))
hl.bind(mainMod .. " + 0", hl.dsp.exec_cmd("kitty nohup waybar &"))


-- TODO: Add auto-generate shortcuts from this file
--hl.bind(mainMod .. " + H", hl.dsp.exec_cmd("~/.config/hypr/generate-shortcuts.sh"))

-- ============================================================
-- ======            KEYBINDINGS WORKSPACE               ======
-- ============================================================
-- move focus
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

-- Move / focus window to workspace fixed number
for i = 0, 9 do
    hl.bind(mainMod .. " + SHIFT + " .. tostring(i), hl.dsp.window.move({ workspace = i }))
    hl.bind(mainMod .. " + " .. tostring(i), hl.dsp.focus({ workspace = i }))
end


-- Move window to previous workspace (left)
hl.bind(mainMod .. " + SHIFT + left", function()
    local currentWs = hl.get_active_monitor().active_workspace
    hl.dispatch(hl.dsp.window.move({ workspace = currentWs.id - 1 }))
end)

-- Move window to next workspace (right)
hl.bind(mainMod .. " + SHIFT + right", function()
    local currentWs = hl.get_active_monitor().active_workspace
    hl.dispatch(hl.dsp.window.move({ workspace = currentWs.id + 1 }))
end)

-- Swap active window with neighbor using Super + SHIFT + Arrow Keys
hl.bind(mainMod .. " + ALT + left", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + ALT + up", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + ALT + down", hl.dsp.window.swap({ direction = "down" }))


-- send focused workspace to left/right monitors
hl.bind(mainMod .. " + ALT + SHIFT + left", hl.dsp.workspace.move({ monitor = "l" }))
hl.bind(mainMod .. " + ALT + SHIFT + right", hl.dsp.workspace.move({ monitor = "r" }))

-- Move active window to Next Monitor (Right)
hl.bind(mainMod .. " + ALT + Right", hl.dsp.exec_cmd("hyprctl dispatch moveintomonitorscreen next"))

-- Move active window to Previous Monitor (Left)
hl.bind(mainMod .. " + ALT + Left", hl.dsp.exec_cmd("hyprctl dispatch moveintomonitorscreen prev"))



-- ============================================================
-- ======             MOUSE DRAG & RESIZE                  ======
-- ============================================================
-- FIXME: click mouse and drag it to another place
--
-- -- Drag Window (Move)
-- -- Requires the window to be floating or toggling float on drag
-- hl.bind(mainMod .. " + mouse:272", hl.dsp.window.move(), { mouse = true })

-- -- Resize Window (Bottom-Right corner usually, or any border if configured)
-- hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- -- Alternative Resize (Alt + Click to resize from wherever you click)
-- hl.bind(mainMod .. " + ALT + mouse:272", function()
--     -- Toggle floating mode temporarily or just resize
--     hl.dispatch("resizeactive", "current")
--     hl.dsp.window.resize()
-- end, { mouse = true })



-- ============================================================
-- ======              KEYBINDINGS LAYOUT                ======
-- ============================================================
-- FIXME: changing layout with keybindings, and show it on waybar
-- hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd("hyprctl dispatch setlayout dwindle"))
-- hl.bind(mainMod .. " + F2", hl.dsp.exec_cmd("hyprctl dispatch setlayout master"))
-- hl.bind(mainMod .. " + F3", hl.dsp.exec_cmd("hyprctl dispatch setlayout next"))




-- FIXME: Rsize windows in Hyprland
-- ============================================================
-- ======             KEYBINDINGS RESISING               ======
-- ============================================================
-- Resize window right (increase width)
-- hl.bind(mainMod .. " + CTRL + right", function()
-- hl.dispatch("resizeactive", "50 0")
-- end)
--
-- -- Resize window left (decrease width)
-- hl.bind(mainMod .. " + CTRL + left", function()
-- hl.dispatch("resizeactive", "-50 0")
-- end)
--
-- -- Resize window up (decrease height)
-- hl.bind(mainMod .. " + CTRL + up", function()
-- hl.dispatch("resizeactive", "0 -50")
-- end)
--
-- -- Resize window down (increase height)
-- hl.bind(mainMod .. " + CTRL + down", function()
-- hl.dispatch("resizeactive", "0 50")
-- end)



-- ============================================================
-- ======           KEYBINDINGS SCREENSHOTS              ======
-- ============================================================
-- TODO: Change screenshot to flameshot
-- Screenshot entire screen → saves to ~/Pictures/Screenshots
hl.bind("SUPER + CTRL + P", hl.dsp.exec_cmd("grim ~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png"))

-- Screenshot selected region → saves to ~/Pictures/Screenshots
hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd("grim -g \"$(slurp)\" ~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png"))

-- Screenshot active window → saves to ~/Pictures/Screenshots
hl.bind("SUPER + ALT + P",
    hl.dsp.exec_cmd(
        "grim -g \"$(hyprctl activewindow -j | jq -r '.at + \\\" \\\" + (.size | [.width, .height] | join(\\\" \\\"))')\" ~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png"))

-- Screenshot region → copies to clipboard instead of saving
hl.bind("CTRL + Print", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy"))




-- ============================================================
-- ======          KEYBINDINGS KEYBOARD KEYS             ======
-- ============================================================
-- TODO:add more keyboard keys
-- media controls
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })

-- volume (locked + repeating)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-"),
    { locked = true, repeating = true })

-- backlight (locked + repeating)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brillo -q -u 300000 -A 5"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brillo -q -u 300000 -U 5"), { locked = true, repeating = true })


-- TODO: add more keyboard shortcuts, calculator, screenshort, and so on

-- Cycle through workspaces like A lt+Tab
--hl.bind(mainMod .. " + TAB",        hl.dsp.focus({ workspace = "previous" }))
--hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.focus({ workspace = "next" }))

-- Cycle through windows in current workspace
--hl.bind("ALT + TAB",       hl.dsp.focus({ window = "next" }))
--hl.bind("ALT + SHIFT + TAB", hl.dsp.focus({ window = "prev" }))
