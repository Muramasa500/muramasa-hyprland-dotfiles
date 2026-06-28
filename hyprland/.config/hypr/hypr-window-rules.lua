-- ============================================================
-- ======                 WINDOW RULES                   ======
-- ============================================================
hl.window_rule({
    match = { class = "org.pulseaudio.pavucontrol" },
    float = true,
    center = true,
    size = { 800, 600 },
    opacity = "0.9 0.9",
})

hl.window_rule({
    match = { class = "me.proton.Pass" },
    float = true,
    center = true,
    size = { 1100, 900 },
    opacity = "0.9 0.9",
})

hl.window_rule({
    match = { class = "flameshot" },
    float = true,
    center = true,
    size = { 800, 600 },
    opacity = "0.9 0.9",
})

hl.window_rule({
    match = { class = "qalculate-gtk" },
    float = true,
    center = true,
    size = { 800, 600 },
    opacity = "0.9 0.9",
})

hl.window_rule({
    match = { class = "soffice" },
    float = true,
    center = true,
    size = { 800, 600 },
    opacity = "0.9 0.9",
})
