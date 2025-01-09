-----------------------------------------------------------------------
-- scripts/mpv2anki/modules/playback.lua
-----------------------------------------------------------------------
-- Get current playback time
-----------------------------------------------------------------------
local mp = require('mp')
local msg = require('mp.msg')

local playback = {}


function playback.get_time_pos()
    -- Get current playback time
    local time_pos = mp.get_property_number("time-pos")

    msg.info("Current playback position: " .. tostring(time_pos))

    if not time_pos then
        msg.error("Could not get current timestamp")
        return
    end

    return time_pos
end


return playback