hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
    master = {
        allow_small_split = true,
        new_status = "slave",
    },
    scrolling = {
        fullscreen_on_one_column = true,
    },
    binds = {
        scroll_event_delay = 0,
    }
})

local function layout_bind(bind_table)
    return function ()
        local workspace = hl.get_active_special_workspace() or
                          hl.get_active_workspace()

        if not workspace then
            return
        end

        local layout = workspace.tiled_layout

        if bind_table[layout] then
            hl.dispatch(bind_table[layout])
        end
    end
end

local mainMod = "SUPER"

-- layout control
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle"}))
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle"}))

-- Move focus with mainMod + arrow keys / hjkl
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }), { repeating = true })
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }), { repeating = true })
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }), { repeating = true })
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }), { repeating = true })
hl.bind(mainMod .. " + H",  hl.dsp.focus({ direction = "left" }), { repeating = true })
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }), { repeating = true })
hl.bind(mainMod .. " + K",    hl.dsp.focus({ direction = "up" }), { repeating = true })
hl.bind(mainMod .. " + J",  hl.dsp.focus({ direction = "down" }), { repeating = true })

-- Move windows with mainMod + SHIFT + arrow keys / hjkl
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }), { repeating = true })

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Resize windows with mainMod + CTRL + arrow keys / hjkl
hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })

-- layout switch
hl.bind(mainMod .. " + tab", function ()
    local layouts     = {"dwindle", "master", "scrolling"}
    local workspace   = hl.get_active_workspace()
    if hl.get_active_special_workspace() then
            workspace = hl.get_active_special_workspace()
    end

    local next_layout = "dwindle"

    if not workspace then
        return
    end

    for i = 1, #layouts do
        if layouts[i] == workspace.tiled_layout then
            local next_layout_idx = (i % #layouts) + 1
            next_layout = layouts[next_layout_idx]
            break
        end
    end

    if workspace.special then
            hl.workspace_rule({ workspace = tostring(workspace.name), layout = next_layout })
    else
            hl.workspace_rule({ workspace = tostring(workspace.id), layout = next_layout })
    end

    hl.exec_cmd("notify-send 'Switched to \"" .. next_layout .. "\" layout'")
end)

-- layout-specific bind
hl.bind(mainMod .. " + R", layout_bind({
    dwindle = hl.dsp.layout("togglesplit"),
    master = hl.dsp.layout("swapwithmaster"),
    scrolling = hl.dsp.layout("fit visible"),
}))
hl.bind(mainMod .. " + mouse:274", layout_bind({
    dwindle = hl.dsp.layout("togglesplit"),
    master = hl.dsp.layout("swapwithmaster"),
    scrolling = hl.dsp.layout("fit visible"),
}))
hl.bind(mainMod .. " + N", layout_bind({
    scrolling = hl.dsp.layout("consume_or_expel prev"),
}))

-- scroll
hl.bind(mainMod .. " + mouse_up", layout_bind({
    dwindle = hl.dsp.layout("splitratio +0.05"),
    master = hl.dsp.layout("mfact +0.02"),
    scrolling = hl.dsp.layout("move +400"),
}))
hl.bind(mainMod .. " + mouse_down", layout_bind({
    dwindle = hl.dsp.layout("splitratio -0.05"),
    master = hl.dsp.layout("mfact -0.02"),
    scrolling = hl.dsp.layout("move -400"),
}), { non_consuming = false })
