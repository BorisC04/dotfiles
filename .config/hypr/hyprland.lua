require("monitors")
require("hyprland.startup")
require("hyprland.general")
require("hyprland.misc")
require("hyprland.animations")
require("hyprland.layout")
require("hyprland.input")
require("hyprland.keybinds")
require("workspaces")
require("hyprland.smart_gaps")
require("hyprland.rules")

local extra = io.popen("ls " .. os.getenv("HOME") .. "/.config/hypr/hyprland/extra/*.lua")
if extra then
    for file in extra:lines() do
        dofile(file)
    end
    extra:close()
end
