-----------------------------------------------------------------------
-- scripts/mpv2anki/modules/views.lua
-----------------------------------------------------------------------
-- Display messages in mpv
-- OSD = "On-Screen Display"
-----------------------------------------------------------------------
local mp = require("mp")
local config = require("config")

local views = {}


function views.show_commands()
    -- Shows available key binding commands for OSD in mpv
    local display = "=== [mpv2anki] Available Commands ===\n"
    for _, info in pairs(config.SHORTCUTS) do
        -- Each info is now a table with {key_binding, description}
        display = display .. "[" .. info[1] .. "] : " .. info[2] .. "\n"
    end

    mp.osd_message(display, 5)  -- Display for 5 seconds
end

-- To implement...
function views.show_error(message)
    mp.osd_message("Error: " .. message, 3)
end

-- To implement...
function views.show_success(message)
    mp.osd_message("Success: " .. message, 3)
end

return views