-----------------------------------------------------------------------
-- scripts/mpv2anki/config.lua
-----------------------------------------------------------------------
--[[
    Configuration file for MPV to Anki script
    This file contains all the settings for:
    - Anki integration (deck name, note type, fields mapping)
    - Media settings (screenshot, audio quality)
    - Keyboard shortcuts
    - FFmpeg path

    Make sure to adjust the MEDIA_PATH according to your Anki profile
    And configure the FIELDS mapping to match your note type structure
    See mpv/script-opts/mpv2anki.conf

]]--
-----------------------------------------------------------------------
local mp = require 'mp'


-- Simple function to parse comma-separated tags
local function parse_tags(tags_str)
    local tags = {}
    for tag in string.gmatch(tags_str, "([^,]+)") do
        table.insert(tags, tag:match("^%s*(.-)%s*$"))
    end
    return tags
end

-- Read and parse the config file
local function read_config_file()
    local config = {}
    local path = mp.command_native({"expand-path", "~~/script-opts/mpv2anki.conf"})

    local file = io.open(path, "r")
    if file then
        for line in file:lines() do
            -- Skip comments and empty lines
            if line:match("^%s*[^#]") then
                local key, value = line:match("^%s*([^=]+)%s*=%s*(.-)%s*$")
                if key and value then
                    config[key] = value
                end
            end
        end
        file:close()
    end

    return config
end

-- Get OS-specific paths with username from config
local function get_os_specific_paths()
    local config = read_config_file()
    local username = config.anki_username or "User 1"
    local home = os.getenv('HOME')

    -- Detect OS
    local os_name = package.config:sub(1,1) == '\\' and 'windows' or
            (io.popen('uname -s'):read('*l') == 'Darwin' and 'macos' or 'linux')

    -- Set paths based on OS
    local paths = {
        windows = {
            ffmpeg_path = config.ffmpeg_path or 'C:\\mpv\\ffmpeg.exe',
            media_path = string.format('%s\\Anki2\\%s\\collection.media\\',
                    os.getenv('APPDATA') or '', username)
        },
        macos = {
            ffmpeg_path = config.ffmpeg_path or '/usr/local/bin/ffmpeg',
            media_path = home .. '/Library/Application Support/Anki2/' .. username .. '/collection.media/'
        },
        linux = {
            ffmpeg_path = config.ffmpeg_path or '/usr/bin/ffmpeg',
            media_path = home .. '/.local/share/Anki2/' .. username .. '/collection.media/'
        }
    }

    return paths[os_name:lower()] or paths.linux
end


local function get_config()
    local user_config = read_config_file()
    local paths = get_os_specific_paths()

    return {
        FFMPEG = {
            PATH = paths.ffmpeg_path
        },
        ANKI = {
            ANKICONNECT_URL = user_config.ankiconnect_url or 'http://localhost:8765',
            MEDIA_PATH = paths.media_path,
            DECK_NAME = user_config.deck_name or 'Sentence Mining',
            NOTE_TYPE = user_config.note_type or 'mpv2anki',
            FIELDS = {
                SUBTITLE1 = user_config.field_subtitle1 or 'Sentence',
                SUBTITLE2 = user_config.field_subtitle2 or 'Translation',
                AUDIO = user_config.field_audio or 'SentenceAudio',
                SCREENSHOT = user_config.field_screenshot or 'Screenshot'
                -- *********** ADDITIONAL FIELDS ***************
                -- ADD ANY FIELD HERE or INSIDE mpv/script-opts/mpv2anki.conf
                -- AND modules/ankiconnect.lua
                -- SUBTITLE1_EXTRA = user_config.field_subtitle1_extra or 'SentencePinyin'
                -- IS_SENTENCE_CARD = user_config.is_sentence_card or 'x'
                -- SOURCE = user_config.source or ''

            },
            TAGS = parse_tags(user_config.tags or 'mpv,sentence-mining')
        },
        MEDIA = {
            FORMAT_IMAGE = user_config.format_image or 'jpg',
            FORMAT_AUDIO = user_config.format_audio or 'mp3'
        },
        SHORTCUTS = {
            PAUSE_AND_CAPTURE = {user_config.shortcut_pause_and_capture or "Shift+d", "Pause and capture to Anki"},
            SHOW_COMMANDS = {user_config.shortcut_show_commands or "Shift+h", "Show all commands"}
        }
    }
end

return get_config()