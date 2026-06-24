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
-- ======                  DEBUG MODE                    ======
-- ============================================================
hl.config({
    debug = {
        disable_logs = false,
        -- enable_stdout_logs = true,
    }
})


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
-- ======                WORKSPACE RULES                 ======
-- ============================================================
hl.workspace_rule({ workspace = "1", monitor = "DP-1", persistent = true })
-- hl.workspace_rule({ workspace = "2", monitor = "DP-1", persistent = true})

hl.workspace_rule({ workspace = "2", monitor = "DP-2", persistent = true })
-- hl.workspace_rule({ workspace = "4", monitor = "DP-2", persistent = true})

hl.workspace_rule({ workspace = "3", monitor = "HDMI-A-1", persistent = true })
-- hl.workspace_rule({ workspace = "6", monitor = "HDMI-A-1", persistent = true})


hl.exec_cmd("hyprctl keyword workspace 1")
hl.exec_cmd("hyprctl keyword workspace 2")
hl.exec_cmd("hyprctl keyword workspace 3")


-- ============================================================
-- ======                AUTOSTART                       ======
-- ============================================================

hl.on("hyprland.start", function()
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

    -- Cliboard
    hl.exec_cmd("wl-paste --type text --watch cliphist store &")
    hl.exec_cmd("wl-paste --type image --watch cliphist store &")
end)



-- TODO: is it possible to have a floating window show up to show pavucontrol?
-- hl.config({
--     windowrulev2 = {
--         "float, class:org.pulseaudio.pavucontrol",
--         "center, class:org.pulseaudio.pavucontrol",
--         "size 800 600, class:org.pulseaudio.pavucontrol",
--     }
-- })


-- ============================================================
-- ======                 KEYBINDINGS                    ======
-- ============================================================
require("hypr-shortcuts")


-- ============================================================
-- ======                LOOK AND FEEL                   ======
-- ============================================================

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in          = 8,
        gaps_out         = 10,

        border_size      = 2,

        col              = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing    = false,

        layout           = "dwindle",
    },


    -- ============================================================
    -- ======                  DECORATION                    ======
    -- ============================================================

    decoration = {
        rounding         = 12, -- Slightly rounder corners (10 -> 12)
        rounding_power   = 2,

        active_opacity   = 1.0,
        inactive_opacity = 0.92, -- Slightly more transparent when unfocused

        shadow           = {
            enabled      = true,
            range        = 12,               -- Wider shadow range (4 -> 12) for a softer glow
            render_power = 3,
            color        = "rgba(000000bb)", -- Softer black shadow
        },

        blur             = {
            enabled           = true,
            size              = 6,    -- Stronger blur (2 -> 6)
            passes            = 2,    -- More passes for smoother blur (1 -> 2)
            vibrancy          = 0.1696,
            new_optimizations = true, -- Enable newer blur optimizations
        },
    },
    animations = {
        enabled = true,
    },
})

-- ============================================================
-- ======                    ANIMATIONS                  ======
-- ============================================================

-- Define smoother, more modern curves
hl.curve("easeOutCirc", { type = "bezier", points = { { 0.0, 0.0 }, { 0.0, 1.0 } } })       -- Very smooth start/end
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1.0 } } }) -- Classic modern ease
hl.curve("easeOutQuart", { type = "bezier", points = { { 0.16, 1.0 }, { 0.3, 1.0 } } })     -- Fast start, long smooth tail
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("easeOutCirc", { type = "bezier", points = { { 0.0, 0.0 }, { 0.0, 1.0 } } })
hl.curve("easeOutCubic", { type = "bezier", points = { { 0.33, 1.0 }, { 0.66, 1.0 } } }) -- Approximation
hl.curve("easeOutQuart", { type = "bezier", points = { { 0.16, 1.0 }, { 0.3, 1.0 } } })


hl.animation({ leaf = "global", enabled = true, speed = 8.0, bezier = "easeOutCubic" })
hl.animation({ leaf = "border", enabled = true, speed = 6.0, bezier = "easeOutQuart" })
hl.animation({ leaf = "windows", enabled = true, speed = 5.0, bezier = "easeOutCubic" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.5, bezier = "easeOutCirc", style = "popin 90%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3.5, bezier = "easeOutCubic", style = "popin 90%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 5.0, bezier = "easeOutCubic" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 4.0, bezier = "easeOutCubic" })
hl.animation({ leaf = "fade", enabled = true, speed = 6.0, bezier = "easeOutCirc" })
hl.animation({ leaf = "layers", enabled = true, speed = 5.5, bezier = "easeOutCubic" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 5.0, bezier = "easeOutCirc", style = "popin 90%" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 3.5, bezier = "easeOutCubic", style = "popin 90%" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 5.0, bezier = "easeOutCubic" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 3.5, bezier = "easeOutCubic" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4.5, bezier = "easeOutCirc", style = "slide" }) -- Changed to 'slide' for smoother workspace switching
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 4.5, bezier = "easeOutCirc", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 4.5, bezier = "easeOutCirc", style = "slide" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 8.0, bezier = "easeOutCirc" })



-- ============================================================
-- ======                 WINDOW RULES                   ======
-- ============================================================


-- ============================================================
-- ======                LAYOUT PLUGINS                  ======
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
