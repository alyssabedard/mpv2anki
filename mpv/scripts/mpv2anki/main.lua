-----------------------------------------------------------------------
-- scripts/mpv2anki/main.lua
-- Created by: Alyssa Bédard
--      - GitHub: https://github.com/alyssabedard/
--      - mpv2anki: https://github.com/alyssabedard/mpv2anki
-----------------------------------------------------------------------
--[[
    Created by: Alyssa Bédard
    GitHub: https://github.com/alyssabedard/
    mpv2anki: https://github.com/alyssabedard/mpv2anki

    Main script.
    Read mpv2anki/config.lua and change values and settings to your preferences

    Some notes:
    - Screenshots and subtitles: mpv has built-in command → use mp.commandv and mp.get_property
    - Audio extraction: needs external tool (ffmpeg) → use mp.command_native with subprocess
    Read mpv documentation: https://mpv.io/manual/stable/#lua-scripting
    TODO:
    - More error handling
]]--
-----------------------------------------------------------------------

local mp = require('mp')
local msg = require('mp.msg')

local ankiconnect = require('modules.ankiconnect')
local views = require('modules.views')
local subs = require('modules.subtitles')
local audio  = require('modules.audio')
local screenshot = require('modules.screenshot')
local config = require('config')
local helper = require('helper')



-----------------------------------------------------------------------
-- Modules function calls
-- TODO: Need more error/exception messages for debugging

local function create_screenshot(filename)
    local res = screenshot.create_screenshot(filename)
    return res
end

local function create_audio(filename)
    local res = audio.create_audio(filename)
    return res
end

local function send_to_anki(note_data)
    local res = ankiconnect.send_to_anki(note_data)
    return res
end

local function show_commands()
    views.show_commands()
end


-----------------------------------------------------------------------
-- Helper functions
-- TODO: Need more error/exception messages for debugging

local function generate_filename(type)
    local res = helper.generate_filename(type)
    return res
end

local function check_media_path()
  local res =  helper.check_media_path()
  return res
end


-----------------------------------------------------------------------
-- Main function to capture screenshot and 
-- audio with subs and send to Anki

local function capture_to_anki()
    mp.osd_message("Starting mpv2anki...", 3)  -- Display for 3 seconds

    if not check_media_path() then
        mp.osd_message("Failed to add card to Anki", 2)
        return  -- Exit if media path check fails
    end


    -- Generate filenames
    local screenshot_filename = generate_filename("screenshot")
    local audio_filename = generate_filename("audio")

    
    -- Generate actual files
    create_screenshot(screenshot_filename)
    -- If video is a stream or issue with ffmpeg command
    if not create_audio(audio_filename) then audio_filename = "" end
    
    local sub1, sub2 = subs.get_subtitles()

    local note_data = {
        sub1 = sub1,
        sub2 = sub2,
        screenshot_filename = screenshot_filename,
        audio_filename = audio_filename
    }

    local success, response = send_to_anki(note_data)

    if success then
        mp.osd_message("Successfully added card to Anki", 3)
        msg.info("Successfully added card to Anki")
    else
        mp.osd_message("Failed to add card to Anki", 3)
        msg.error("Failed to add card to Anki: " .. (response or "unknown error"))
    end
end

-- Pause video before capturing to Anki
local function pause_and_capture()
    mp.set_property_bool("pause", true)
    capture_to_anki()
end

-----------------------------------------------------------------------
-- Bind to shortcut keys

--[[ 
    For iina, make sure to add to settings (Documentation coming soon...)

    key: the shortcut
    value: script-binding name-binding

    ex.: Ctrl + a    script-binding    capture-for-anki_connect

    Note: Make sure you don't have another binding name with the same name
    if you have another scripts and binding with the same name it might create a conflict !
]]
--mp.add_key_binding(config.SHORTCUTS.CAPTURE[1], "capture-to-anki", capture_to_anki) -- To implement
--mp.add_key_binding(config.SHORTCUTS.PAUSE_AND_CAPTURE[1], "pause-and-capture", pause_and_capture)
--mp.add_key_binding(config.SHORTCUTS.SHOW_COMMANDS[1], "show-commands", show_commands)
local function setup_keybindings()
    for _, binding in pairs({
        {config.SHORTCUTS.PAUSE_AND_CAPTURE[1], "pause-and-capture", pause_and_capture},
        {config.SHORTCUTS.SHOW_COMMANDS[1], "show-commands", show_commands}
    }) do
        if binding[1] then
            mp.add_key_binding(binding[1], binding[2], binding[3])
        else
            msg.error(string.format("Missing keybinding configuration for %s", binding[2]))
        end
    end
end

setup_keybindings()

