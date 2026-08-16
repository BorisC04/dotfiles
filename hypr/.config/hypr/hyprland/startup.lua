-- AUTOSTART
hl.on("hyprland.start", function ()
    hl.exec_cmd("thunar --daemon")
    hl.exec_cmd("wl-clip-persist --clipboard regular")
    hl.exec_cmd("waybar & hyprpaper & blueman-applet & swaync & hypridle")
    hl.exec_cmd("discord --start-minimized")
    hl.exec_cmd("steam -silent")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("fcitx5 --replace -d")
    hl.exec_cmd("easyeffects --gapplication-service")
end)

-- ENVIRONMENT VARIABLES
hl.env("XCURSOR_SIZE","24")
hl.env("GDK_SCALE", "2")

hl.env("LIBVA_DRIVER_NAME","nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME","nvidia")
hl.env("NVD_BACKEND", "direct")                     -- allow hardware acceleration
hl.env("ELECTRON_OZONE_PLATFORM_HINT","auto")

hl.env("QT_QTA_PLATFORMTHEME","hyprqt6engine")
hl.env("QT_STYLE_OVERRIDE","kvantum")
hl.env("QT_IM_MODULE","fcitx")

hl.env("SDL_IM_MODULE","fcitx")

hl.env("HYPRCURSOR_THEME","hyprland")
hl.env("HYPRCURSOR_SIZE","24")

hl.env("EDITOR","nvim")
