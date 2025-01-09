-----------------------------------------------------------------------
-- scripts/mpv2anki/modules/audio.lua
-----------------------------------------------------------------------
--[[
    Audio Extraction Module for MPV to Anki

    Core functionality:
    - Extracts audio segments from video files based on subtitle timing
    - Handles both local files and streams (stream support in development...)
    - Uses FFmpeg for audio extraction and conversion
    - Adds small padding before/after subtitle timing for natural sound

    Features:
    - Automatic FFmpeg detection and version checking
    - Local file audio extraction with customizable parameters

    TODO:
    - Support for streams via yt-dlp (audio saving not implemented yet)
    - Configurable audio format and quality settings


    Note: Stream audio extraction is planned but not yet implemented.
    Check config.lua for FFmpeg path and audio settings configuration.
]]
-----------------------------------------------------------------------

local mp = require('mp')
local msg = require('mp.msg')
local config = require('config')
local subs = require('modules.subtitles')

local audio = {}
local is_stream = false

-------------------------------------------------------------------
-- Check if ffmpeg installed
-------------------------------------------------------------------
-- !!! Check config.lua FFMPEG path !!!
local function check_ffmpeg()
    local result = mp.command_native({          -- mp.command_native is MPV's function for running system commands
        name = "subprocess",                    -- Tells MPV we want to run an external program as a subprocess
        args = {config.FFMPEG.PATH, "-version"},
        capture_stdout = true,                  -- Captures normal output from the command
        capture_stderr = true                   -- Captures any error messages
    })

    if result.status ~= 0 then
        msg.error("ffmpeg not found at configured path: " .. config.FFMPEG.PATH)
        return false
    end

    -- Capture everything until the first newline (to get ffmpeg version)
    msg.info("ffmpeg found: " .. (result.stdout:match("[^\n]*") or "unknown version"))

    return config.FFMPEG.PATH
end

-------------------------------------------------------------------
-- For local files (non-streams)
-------------------------------------------------------------------
function audio.create_audio_file(filename)

    -- Check if FFmpeg is available before proceeding
    local ffmpeg_path = check_ffmpeg()
    if not ffmpeg_path then
        return false
    end

    -- Get the current video file path and set output path in Anki media folder
    local input_file = mp.get_property('path')
    local output_path = config.ANKI.MEDIA_PATH .. filename

    msg.info("Input file: " .. input_file)

    -- Get subtitle timing and calculate duration with padding
    local sub_start, sub_end = subs.get_sub_timing()
    local duration = sub_end - sub_start
    local padding_start = 0.1               -- Add small padding at start
    local padding_end = 0.2                 -- Add padding at end
    local buffered_duration = duration + padding_start + padding_end

    -- Prepare FFmpeg command arguments
    local args = {
        ffmpeg_path,
        "-y",                   -- Overwrite output file if it exists
        "-i", input_file,       -- Input file
        "-ss", string.format("%.3f", sub_start - padding_start),  -- Start time with padding
        "-t", string.format("%.3f", buffered_duration),           -- Duration to extract
        "-map", "0:a",          -- Select audio stream
        "-c:a", "libmp3lame",   -- Use MP3 codec
        "-q:a", "2",            -- Set audio quality (2 is high quality, range is 0-9)
        output_path
    }

    -- Debug: print the exact command being used
    msg.info("FFmpeg command: " .. table.concat(args, " "))

    -- Execute FFmpeg command as subprocess
    local result = mp.command_native({
        name = "subprocess",
        args = args,
        capture_stdout = true,          -- Capture command output
        capture_stderr = true           -- Capture any errors
    })

    -- Check if FFmpeg command was successful
    if result.status ~= 0 then
        msg.error("Failed to create audio. Status: " .. tostring(result.status))
        msg.error("stderr: " .. (result.stderr or "none"))
        return false
    end

    return true
end

-------------------------------------------------------------------
-- STREAMS
-------------------------------------------------------------------
-- Not implemented yet
-- The non stream function should handle streaming videos supported by yt-dlp,
function audio.create_stream_audio_file(filename)
    msg.info("Audio Type: Stream, not implemented as of now, see modules/audio.lua")
    -- local res = audio.create_audio_file(filename)
    return false
end


-------------------------------------------------------------------
-- Helper functions
-------------------------------------------------------------------
-- to determine if the current media is a stream
function audio.is_stream()
    local path = mp.get_property("path")
    return path and path:match("^https?://") ~= nil
end

-------------------------------------------------------------------
-- Main create_audio function
-------------------------------------------------------------------
function audio.create_audio(filename)
    if audio.is_stream() then
        return audio.create_stream_audio_file(filename)
    else
        return audio.create_audio_file(filename)
    end
end


return audio