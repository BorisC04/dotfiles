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

-- Layer rules
hl.layer_rule({ match = { namespace = "wofi" }, blur = true})
hl.layer_rule({ match = { class = "swaync-notication-window"}, blur = false})
