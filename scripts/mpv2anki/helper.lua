-----------------------------------------------------------------------
-- scripts/mpv2anki/helper.lua
-----------------------------------------------------------------------
--[[
    Helper functions for MPV to Anki script

    Core utility functions that handle:
    - File name generation for screenshots and audio clips
    - Each file is named with timestamp for uniqueness (e.g. mpv2anki_1234567_screenshot.jpg)
    - Media path validation to ensure Anki media directory exists
    - Formats supported: jpg images, mp3 for audio
]]--
-----------------------------------------------------------------------


local utils = require('mp.utils')
local msg = require('mp.msg')
local config = require('config')



local helper = {}

function helper.generate_filename(type)
    local timestamp = os.time()
    
    if type == "screenshot" then
        return "mpv2anki_" .. timestamp .. "_screenshot." .. config.MEDIA.FORMAT_IMAGE

    elseif type == "audio" then
        return "mpv2anki_" .. timestamp .. "_audio." .. config.MEDIA.FORMAT_AUDIO

    else
        msg.warn("Unknown file type: " .. (type or "nil"))
        return "mpv2anki_" .. timestamp .. "_unknown"
    end
end


function helper.check_media_path()
    local dir_info = utils.file_info(config.ANKI.MEDIA_PATH)

    if dir_info and dir_info.is_dir then
        msg.info("Anki media directory found at: " .. config.ANKI.MEDIA_PATH)
        return true

    else
        msg.error("Anki media directory not found at: " .. config.ANKI.MEDIA_PATH)
        return false
    end
end


return helper
