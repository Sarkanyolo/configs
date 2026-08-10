-- Remove outer gaps when the focused workspace has only one tiled window.
-- (dwindle:no_gaps_when_only was removed, so this replicates it via events)

local GAPS_OUT_SINGLE   = 0
local GAPS_OUT_DEFAULT  = 0 -- must match general.gaps_out in decorations.lua

local BORDER_SINGLE  = 0
local BORDER_DEFAULT = 2 -- must match general.border_size in decorations.lua

local ROUNDING_SINGLE  = 0
local ROUNDING_DEFAULT = 2 -- must match decoration.rounding in decorations.lua

local BLUR_SINGLE  = false
local BLUR_DEFAULT = true

local function updateGaps()
    local ws = hl.get_active_workspace()
    if not ws or ws.special then
        return
    end

    local tiled = 0
    for _, w in ipairs(hl.get_workspace_windows(ws)) do
        if not w.floating then
            tiled = tiled + 1
        end
    end

    local single = tiled <= 1
    hl.config({
        general = {
            gaps_out    = single and GAPS_OUT_SINGLE or GAPS_OUT_DEFAULT,
            border_size = single and BORDER_SINGLE or BORDER_DEFAULT,
        },
        decoration = {
            rounding = single and ROUNDING_SINGLE or ROUNDING_DEFAULT,
            blur     = { enabled = single and BLUR_SINGLE or BLUR_DEFAULT },
        },
    })
end

hl.on("window.open",                updateGaps)
hl.on("window.close",               updateGaps)
hl.on("window.destroy",             updateGaps)
hl.on("window.move_to_workspace",   updateGaps)
hl.on("workspace.active",           updateGaps)
hl.on("config.reloaded",            updateGaps)
