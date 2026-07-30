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
})

-- dwindle
hl.bind("SUPER + P", hl.dsp.window.pseudo())
hl.bind("SUPER + R", layout_bind({
    dwindle = hl.dsp.layout("swapsplit"),
    master = hl.dsp.layout("swapwithmaster"),
}))
hl.bind("SUPER + mouse:274", layout_bind({
    dwindle = hl.dsp.layout("swapsplit"),
    master = hl.dsp.layout("swapwithmaster"),
}))

hl.bind("SUPER + tab", function ()
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
