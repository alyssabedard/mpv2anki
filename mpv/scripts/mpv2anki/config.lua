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
]]--
-----------------------------------------------------------------------

local config = {
    -----------------------------------------------------------------------
    -- FFMPEG PATHS
    -----------------------------------------------------------------------
    -- Change according to your currentOS and path...
    FFMPEG = {
        PATH = '/usr/local/bin/ffmpeg'
    },
    -----------------------------------------------------------------------
    -- Anki related settings
    -----------------------------------------------------------------------
    -- !!!!!!! Change MEDIA_PATH  and FIELDS to match your setup !!!!!!!!
    -- Make sure to adjust fields inside modules/ankiconnect.lua request params
    ANKI = {
        ANKICONNECT_URL = 'http://localhost:8765',
        MEDIA_PATH = os.getenv('HOME') .. '/Library/Application Support/Anki2/MyTestProfile/collection.media/',
        DECK_NAME = '中文',
        NOTE_TYPE = 'Sentence Mining (中文)',
        FIELDS = {      
            SUBTITLE1='Sentence',
            SUBTITLE2='Translation',
            AUDIO='SentenceAudio',
            SCREENSHOT='Image',
            SUBTITLE1_EXTRA = "SentencePinyin",
            IS_SENTENCE_CARD = "IsSentenceCard",
            SOURCE = "Source",
        },
        TAGS = {'mpv', 'sentence-mining'}
    },
    -----------------------------------------------------------------------
    -- Multimedia settings
    -----------------------------------------------------------------------
    MEDIA = {
        FORMAT_IMAGE = 'jpg',
        FORMAT_AUDIO = 'mp3',
    },

    -----------------------------------------------------------------------
    -- Keyboard shortcuts
    -----------------------------------------------------------------------
    SHORTCUTS = {
        CAPTURE = {'Shift+a', "Capture to Anki"},
        PAUSE_AND_CAPTURE = {"Shift+d", "Pause and capture to Anki"},
        SHOW_COMMANDS = {'Shift+h', "Show all commands"},
    },
}

return config
