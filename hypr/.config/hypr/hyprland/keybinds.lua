-- PROGRAMS VARIABLES
local terminal = "foot"
local fileManager = "thunar"
-- local menu = "wofi --show drun"
local menu = "rofi -show drun"
local menuKill = "pkill rofi"

-- check tag method
local function hasTag(window, tag)
    if not window then return false end
    for _, t in ipairs(window.tags or {}) do
        if t == tag then
            return true
        end
    end
    return false
end


-- KEYBINDINGS
local mainMod = "SUPER"

-- Functions
hl.bind(mainMod .. " + C", function()
    -- check if window is protected with tags
    if not hasTag(hl.get_active_window(), "protected*") then
        hl.dispatch(hl.dsp.window.close())
    end
end)

hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + ALT + CTRL + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd(menuKill .. " || ~/.local/bin/powermenu.sh"))

-- Monitors
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("nwg-displays"))

-- Applications
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(menuKill .. " || " .. menu))
hl.bind(mainMod .. " + Comma", hl.dsp.exec_cmd(menuKill .. " || rofimoji"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("steam"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("discord --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto"))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("zen-browser"))

-- Color picker
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a -f hex"))

-- Screenshot
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region output --clipboard-only"))
hl.bind(mainMod .. " + SHIFT + ALT + S", hl.dsp.exec_cmd("hyprshot -m window output --clipboard-only"))
hl.bind(mainMod .. " + SHIFT + CTRL + S", hl.dsp.exec_cmd("hyprshot -m output --clipboard-only"))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
