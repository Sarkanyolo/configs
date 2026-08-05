-- Monitor wiki https://wiki.hypr.land/Configuring/Basics/Monitors/
-- Output name: see `hyprctl monitors`. Set MONITOR1 in variables.lua.

hl.monitor({
    output    = MONITOR1,
    mode      = "preferred",
    position  = "auto",
    scale     = "1",
})
