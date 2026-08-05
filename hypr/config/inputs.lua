-- Input configuration

hl.config({
    input = {
        -- sensitivity = -0.25,
        accel_profile = "adaptive",
        kb_layout = "hu",
        numlock_by_default = true,
        -- 2 = hover scrolls the window under the cursor, but keyboard focus
        -- only moves on click (keeps focus on floating windows when hovering
        -- the background). 0 = strict click-to-focus.
        follow_mouse = 2,
        float_switch_override_focus = 0,
    },
})
