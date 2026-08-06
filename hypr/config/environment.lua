-- Environmental variables (for reference https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/)
-- if you use UWSM, define your variables in ~/.config/uwsm/env
-- if you don't use UWSM, define your variables here (e.g. hl.env("QT_QPA_PLATFORM", "wayland"))

hl.env("XDG_MENU_PREFIX", "arch-")

hl.on("hyprland.start", function ()
    hl.exec_cmd("kbuildsycoca6 --noincremental")
end)
