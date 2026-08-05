-- Look and feel configuration
-- Border/group colors are handled by noctalia.lua (apply_theme)

hl.config({
    general = {
        gaps_in = 1,
        gaps_out = 3,
        border_size = 2,
        extend_border_grab_area = 10,
        resize_on_border = true,
    },
    decoration = {
        dim_special = 0.3,
        rounding = 8,
        active_opacity = 1,
        inactive_opacity = 0.9,
        fullscreen_opacity = 1,
        blur = {
            size = 5,
            passes = 4,
            special = true,
        },
    },
})
