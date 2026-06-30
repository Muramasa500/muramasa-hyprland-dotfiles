-- Settings for shortcuts
require("hypr-shortcuts")
-- Settings for window rules
require("hypr-window-rules")
-- Settings for styling
require("hypr-styling")


-- ============================================================
-- ======                  DEBUG MODE                    ======
-- ============================================================
hl.config({
    debug = {
        disable_logs = false,
        -- enable_stdout_logs = true,
    }
})

-- ============================================================
-- ======              ENVIRONMENT VARIABLES             ======
-- ============================================================
-- Force Hyprland to use nvidia GPU, and not integrated GPU
hl.env("AQ_DRM_DEVICES", "/dev/dri/card1")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("HYPRCURSOR_GPU", "nvidia")

-- # Hyprland integration
hl.env("GTK_IM_MODULE", "fcitx")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("SDL_VIDEODRIVER", "wayland")

-- NVIDIA setup
hl.env("__NV_PRIME_RENDER_OFFLOAD", "1")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("__VK_LAYER_NV_optimus", "NVIDIA_only")

-- Force GTK themes
hl.env("GTK_USE_PORTAL", "1")
hl.env("GTK_THEME", "catppuccin-macchiato-blue-standard+default")

-- Force Qt themes
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

--Sometimes helps with Nvidia/Wayland rendering
hl.env("XWAYLAND_FORCE_TRUE_COLOR", "1")
hl.env("WLR_DRM_NO_ATOMIC", "1")


-- ============================================================
-- ======                AUTOSTART                       ======
-- ============================================================
hl.on("hyprland.start", function()
    -- Export variables systemd
    -- hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- -- Restart portals
    -- hl.exec_cmd("systemctl --user stop xdg-desktop-portal xdg-desktop-portal-hyprland")
    -- hl.exec_cmd("systemctl --user start xdg-desktop-portal-hyprland xdg-desktop-portal")


    -- Kill any existing portal instances to prevent conflict
    hl.exec_cmd("killall -9 xdg-desktop-portal || true")
    -- Start only the Hyprland portal
    hl.exec_cmd("/usr/lib/xdg-desktop-portal-hyprland &")

    -- hl.exec_cmd("systemd-run --user --scope /usr/lib/xdg-desktop-portal-hyprland")

    -- Toolkit agent
    hl.exec_cmd("systemctl --user start hyprpolkitagent &")

    hl.exec_cmd("swaync &")

    -- Waybar, task bar manager
    hl.exec_cmd("waybar &")

    -- Wallpaper
    hl.exec_cmd("hyprpaper &")

    -- Sleep mode
    hl.exec_cmd("hypridle &")

    -- Hyprsunset
    hl.exec_cmd("hyprsunset -c ~/.config/hypr/hyprsunset.conf &")

    -- Cliboard
    hl.exec_cmd("wl-paste --type text --watch cliphist store &")
    hl.exec_cmd("wl-paste --type image --watch cliphist store &")

    -- Flameshot in tray
    hl.exec_cmd("flameshot &")
end)


-- ============================================================
-- ======                WORKSPACE RULES                 ======
-- ============================================================
hl.workspace_rule({ workspace = "1", monitor = "DP-1", persistent = true, default = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-1", persistent = true })
hl.workspace_rule({ workspace = "3", monitor = "DP-1", persistent = true })

hl.workspace_rule({ workspace = "4", monitor = "DP-2", persistent = true, default = true })
hl.workspace_rule({ workspace = "5", monitor = "DP-2", persistent = true })
hl.workspace_rule({ workspace = "6", monitor = "DP-2", persistent = true })

hl.workspace_rule({ workspace = "7", monitor = "HDMI-A-1", persistent = true, default = true })
hl.workspace_rule({ workspace = "8", monitor = "HDMI-A-1", persistent = true })
hl.workspace_rule({ workspace = "9", monitor = "HDMI-A-1", persistent = true })


-- hl.exec_cmd("hyprctl keyword workspace 1")
-- hl.exec_cmd("hyprctl keyword workspace 3")
-- hl.exec_cmd("hyprctl keyword workspace 5")


-- ============================================================
-- ======                MONITORS                        ======
-- ============================================================

hl.monitor({
    output = "DP-1",
    mode = "highres",
    position = "0x0",
    scale = 1,
})
hl.monitor({
    output = "DP-2",
    mode = "2560x1440@144",
    position = "1920x0",
    scale = 1,
})
hl.monitor({
    output = "HDMI-A-1",
    -- mode = "1920x1080@60",
    mode = "highres",
    position = "4480x0",
    scale = 0.83,
})


-- ============================================================
-- ======                    LAYOUT                      ======
-- ============================================================

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})


-- ============================================================
-- ======                INPUT                           ======
-- ============================================================
hl.config({
    input = {
        kb_layout  = "se,us",
        kb_options = "grp:alt_shift_toggle",
    }
})
