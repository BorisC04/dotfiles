-- Window rules
local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
suppressMaximizeRule:set_enabled(true);

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    match = { title = "Picture-in-Picture"},
    float = true,
    keep_aspect_ratio = true,
})

hl.window_rule({ match = { class = "nm-connection-editor"}, float = true})
hl.window_rule({ match = { class = "blueman-manager"}, float = true})
hl.window_rule({ match = { title = "galculator"}, float = true})
hl.window_rule({
    name = "overlay-rule",
    match = { class = "((Discover-overlay)|(Overlayed)|(overlayed))"},
    float = true,
    pin = true,
    keep_aspect_ratio = true,
    no_initial_focus = true,
    no_anim = true,
    no_blur = true,
    no_focus = true,
    no_shadow = true,
    rounding = 0,
    decorate = false,
    immediate = true,
})

-- Fix FL Studio on wine
hl.window_rule({ match = { initial_title = "FL Studio 2026"}, float = false, allows_input = true })

-- Layer rules
hl.layer_rule({ match = { namespace = "rofi" }, no_anim = true})
hl.layer_rule({ match = { namespace = "wofi" }, blur = true})
hl.layer_rule({ match = { class = "swaync-notication-window"}, blur = false})
