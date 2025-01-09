-----------------------------------------------------------------------
-- scripts/mpv2anki/modules/subtitles.lua
-----------------------------------------------------------------------
-- Get current subtitles (Primary, Secondary)
-----------------------------------------------------------------------
local mp = require('mp')
local msg = require('mp.msg')
--local playback = require('modules.playback')

local subtitles = {}


function subtitles.get_subtitles()
    local primary_sub = mp.get_property("sub-text") or ""
    local secondary_sub = mp.get_property("secondary-sub-text") or ""

    msg.info("SUBTITLES: " .. primary_sub .. secondary_sub)

    return primary_sub, secondary_sub
end


function subtitles.get_sub_timing()
    
    local sub_start = mp.get_property_number("sub-start")
    local sub_end = mp.get_property_number("sub-end")

    --Debug
    msg.info("Sub_start " .. tostring(sub_start))
    msg.info("Sub_end " .. tostring(sub_end))
    
    if not sub_start or not sub_end then
        msg.error("Could not get sub start or end")
        return
    end
    
    return sub_start, sub_end
end

return subtitles