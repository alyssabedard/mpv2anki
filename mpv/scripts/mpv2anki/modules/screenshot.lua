-----------------------------------------------------------------------
-- scripts/mpv2anki/modules/screenshot.lua
-----------------------------------------------------------------------
-- Take screenshot using mpv's native screenshot command
-- TODO: More error handling
-----------------------------------------------------------------------
local mp = require('mp')
local msg = require('mp.msg')
local config = require('config')

local screenshot = {}


-- If set to true in script-opts/mpv2anki.conf,
-- this function will resize the screenshot image
function screenshot.resize_image(input_path, output_path, width, height)

    quality = 10

    local result = mp.command_native({
        name = "subprocess",
        args = {
            "ffmpeg",
            "-i", input_path,
            "-vf", string.format("scale=%d:%d", width, height), -- Video Filter flag
            "-q:v", tostring(quality),
            "-y",
            output_path
        },
        playback_only = false,
        capture_stdout = true,
        capture_stderr = true
    })

    return result.status == 0
end


function screenshot.create_screenshot(filename)
    local full_path = config.ANKI.MEDIA_PATH .. filename

    -- https://mpv.io/manual/master/#command-interface-screenshot-to-file
    local res = mp.commandv("screenshot-to-file",
            full_path,
            "video"  -- Only capture video, no subtitles (text)
    )

    if not res then
        msg.error("Failed to create screenshot")
        return
    end

    if config.MEDIA.RESIZE_IMAGE == "true" then
        res = screenshot.resize_image(full_path, full_path,640, 360)
        -- res = screenshot.resize_image(full_path, full_path, 320, 180)
        if not res then
            msg.error("Failed to resize screenshot")
            return
        end
    end

    return res
end

return screenshot