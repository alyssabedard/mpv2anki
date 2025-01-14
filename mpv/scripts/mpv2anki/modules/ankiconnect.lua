-----------------------------------------------------------------------
-- scripts/mpv2anki/modules/ankiconnect.lua
-----------------------------------------------------------------------
--[[
    AnkiConnect Integration Module for MPV to Anki

    This module handles communication between MPV and Anki through AnkiConnect:
    - Sends captured screenshots and audio to Anki's media collection
    - Creates new cards with specified fields, deck, and note type
    - Handles HTTP requests to AnkiConnect API (using curl)

    Requirements:
    - AnkiConnect addon must be installed in Anki
    - Anki must be running while using this script


    AnkiConnect Documentation:
        https://foosoft.net/projects/anki-connect/index.html#card-actions
    AnkiConnect Anki Addon:
        https://ankiweb.net/shared/info/2055492159
    Anki Documentation:
        https://docs.ankiweb.net/editing.html#adding-media
]]
-----------------------------------------------------------------------


local mp = require('mp')
local utils = require('mp.utils')
local msg = require('mp.msg')
local config = require('config')

local ankiconnect = {}


--[[
    This sends data to Anki (file names and texts). The actual audio and image files
    will be sent to Anki's media collection with the same file names.
]]
function ankiconnect.send_to_anki(note_data)
    -- Prepare the request to AnkiConnect
    -- Params can be found at the "guiAddCards" section on https://foosoft.net/projects/anki-connect/index.html#card-actions
    local request = {
        action = "guiAddCards", -- Invokes the "Add" Cards dialog in Anki
        version = 6,
        params = {
            note = {
                -- Change params according to your setup and the values inside mpv2anki/modules/config.lua
                deckName = config.ANKI.DECK_NAME or "Default",
                modelName = config.ANKI.NOTE_TYPE or "Basic",
                fields = {

                    [config.ANKI.FIELDS.SUBTITLE1] = note_data.sub1 or "",
                    [config.ANKI.FIELDS.SUBTITLE2] = note_data.sub2 or "",
                    [config.ANKI.FIELDS.SCREENSHOT] = string.format('<img src="%s">', note_data.screenshot_filename), -- HTML formatting because it would just show the filename as text instead
                        [config.ANKI.FIELDS.AUDIO] = note_data.audio_filename ~= "" and string.format('[sound:%s]', note_data.audio_filename) or nil,
                    -- ******** ADDITIONAL FIELDS **********
                    -- Make modifications inside script-opts/mpv2anki.conf and modules/config.lua !!!
                    --[config.ANKI.FIELDS.SUBTITLE1_EXTRA] = note_data.sub1 or "",
                    --[config.ANKI.FIELDS.IS_SENTENCE_CARD] = "x",
                    --[config.ANKI.FIELDS.SOURCE] = ""
                },
                tags = config.ANKI.TAGS or {}
            }
        }
    }

    -- Convert request to JSON
    local json_request = utils.format_json(request)

    msg.info("Sending request to AnkiConnect: " .. json_request)

    -- Send request to AnkiConnect
    local curl_args = {
        "curl",                                 -- curl terminal command
        config.ANKI.ANKICONNECT_URL,            -- AnkiConnect URL
        "-X", "POST",                           -- Specifies this is a POST request
        "-H", "Content-Type: application/json", -- Header indicating we're sending JSON
        "-d", json_request                      -- The actual JSON data we're sending to Anki
    }

    --[[
        We are telling mpv that we want to create and run a new process separate 
        from the main mpv process.
        A subprocess is a child process that is created by another process (parent).
        curl is compatible cross platform and built into mpv.
    ]]
    local result = mp.command_native({  -- Way of running external commands from Lua scripts
        name = "subprocess",            -- Tells mpv we want to run a subprocess
        args = curl_args,
        capture_stdout = true,          -- Capture any output
        capture_stderr = true           -- Capture any error messages
    })
    -- Debug the result (mpv console)
    msg.info("Status: " .. tostring(result.status)) -- Status: 0  (The exit code (0 means success))
    msg.info("Stdout: " .. (result.stdout or "no output")) -- Stdout: {"result": 0, "error": null} 
    -- msg.info("Stderr: " .. (result.stderr or "no error")) -- Stderr:   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current

    return result.status == 0, result.stdout
end

return ankiconnect