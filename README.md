<div align="center">
<h1 style="font-family: monospace;">mpv2anki</h1>
</div>

<div style="text-align: center">
<img src="images/demo.gif" width="1200" alt="Demo of MPV to Anki"/>
</div>
<br>

A simple script to assist your language learning journey in any language by automatically capturing multimedia content from [mpv](https://mpv.io/) to [Anki](https://apps.ankiweb.net/). 
It extracts the current subtitles (target language and native/secondary language), corresponding audio, 
and screenshot when triggered, making it easy to create flashcards.

## Requirements
(all open-source)
- [mpv](https://mpv.io/) (or any software built on mpv like [IINA](https://iina.io/) (MacOS)) - _cross-platform media player_
- [ffmpeg](https://ffmpeg.org/) - _a suite of libraries to handle multimedia files_
- [Anki](https://apps.ankiweb.net/) - _powerful [SRS](https://en.wikipedia.org/wiki/Spaced_repetition) flashcard app_
- [AnkiConnect](https://ankiweb.net/shared/info/2055492159) - _Anki add-on_

_AnkiConnect addon must be installed in Anki and Anki must be running while using this script._


## Features

1. [x] Extract current subtitle text from MPV
2. [x] Capture audio segment corresponding to subtitle timing
3. [x] Take screenshots at current playback position
4. [x] Automatically create Anki cards with extracted content
5. [x] Integration with MPV's keybinding system

### Work in Progress 🚧

#### Custom Audio Segment Selection
Currently, the audio extraction strictly follows subtitle timing. I will work on an additional option that will allow to:
1. [ ] Set custom start and end points for audio clips independent of subtitle timing

#### Documentation
1. [ ] Documentation for non-technical and technical users
2. [ ] Documentation for IINA set-up

#### Video Stream
Audio extraction currently only works with local video files
1. [ ] Audio extraction for URL/Video stream support (platforms supported by [yt-dlp](https://github.com/yt-dlp/yt-dlp))

For video streams I recommend using free tools like [Abs Player](https://chromewebstore.google.com/detail/asbplayer-language-learni/hkledmpjpaehamkiehglnbelcpdflcab) 
that work directly in the web browser.

#### Field Mapping
1. [ ] Simplified field mapping configuration (no code editing required) for non-technical users
2. [ ] Video filename mapping for `[config.ANKI.FIELDS.SOURCE]`


## Documentation 🚧

More detailed documentation is **coming soon** and will be available in the `docs` folder.

_Questions or need help? Open a [Discussion](https://github.com/alyssabedard/mpv2anki/discussions) in this repository. 
Feel free to contribute._

Documentation [here](docs)



## GIF
GIF from 魔道祖师 (_Mo Dao Zu Shi_  |  _Grandmaster of Demonic Cultivation_  |  _The Founder of Diabolism_  |  _The Master of Diabolism_) S01:E02
- [My Anime List (MAL)](https://myanimelist.net/anime/37208/Mo_Dao_Zu_Shi)
- [Douban 豆瓣](https://movie.douban.com/subject/27015848/)

<div align="center">
<img src="images/mytype.png" width="600" alt="Screenshot mo dao zu shi"/>
</div>

Seen in GIF:
- _Anki add-on with pinyin : [Hanzi2Ruby](https://github.com/alyssabedard/Hanzi2Ruby)_ (coming soon)

- _Anki Retro Note Type: [RetroKeAi](https://github.com/alyssabedard/RetroKeAi)_ (coming soon)

