-----------------------------------------------------------------------
-- scripts/mpv2anki/modules/screenshot.lua
-----------------------------------------------------------------------
-- Take screenshot using mpv's native screenshot command
-----------------------------------------------------------------------
local mp = require('mp')
local msg = require('mp.msg')
local config = require('config')

local screenshot = {}

function screenshot.create_screenshot(filename)

    local success = mp.commandv("screenshot-to-file", 
        config.ANKI.MEDIA_PATH .. filename,
        "video"  -- Only capture video, no subtitles (text)
    )
    if not success then
        msg.error("Failed to create screenshot")
        return
    end
    
    return success
end

return screenshot