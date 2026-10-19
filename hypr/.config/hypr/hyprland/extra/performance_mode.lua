hl.bind("SUPER + F1", function ()
    local active = (hl.get_config("animations.enabled") == false)

    if active then
        hl.exec_cmd("hyprctl reload")
        return
    end

    hl.config({
        general = {
            gaps_in = 0,
            gaps_out = 0,
        },

        animations = {
            enabled = false,
        },

        decoration = {
            shadow = { enabled = false },
            blur = { enabled = false },
            rounding = 0,
        }
    })
end)
