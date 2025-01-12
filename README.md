<div align="center">
   <h1 style="font-family: monospace;">mpv2anki</h1>
</div>

## Description
A simple script to assist your language learning journey in any language by automatically capturing multimedia content from [mpv](https://mpv.io/) to [Anki](https://apps.ankiweb.net/).
It extracts the current subtitles (target language and native/secondary language), corresponding audio,
and screenshot when triggered, making it easy to create flashcards.

_Need help? Want to raise an issue? Looking for documentation? See [Contributing & Support](#contributing--support)_

## Demo
<div align="center"><br>
   <img src="docs/screenshots/demo.gif" width="1000" alt="Demo of MPV to Anki"/>
</div>


## Important Notes

**OS**  
This script has been primarily tested on macOS.  I currently don't have access to a Linux and Windows machines for thorough testing.

_Windows Status (2025-01-10): Currently debugging MPV script loading issues_

## Features

1. [x] Automatically create Anki cards with extracted content
   1. [x] Extract current subtitle text from MPV
   2. [x] Capture audio segment corresponding to subtitle timing
   3. [x] Take screenshots at current playback position


### Planned Features

1. [ ] **Custom Audio Segment Selection** _(See Note 1)_
   1. [ ] Set custom start and end points for audio clips independent of subtitle timing
2. [ ] **Documentation**
   1. [ ] for non-technical users
   2. [ ] for IINA set-up
3. [ ] **Audio extraction** _(See Note 2)_
   1. [ ] for URL/Video stream support (platforms supported by [yt-dlp](https://github.com/yt-dlp/yt-dlp))
4. [ ] **Field Mapping**
   1. [ ] Simplified field mapping configuration (no code editing required) for non-technical users
   2. [ ] Video filename mapping for `[config.ANKI.FIELDS.SOURCE]`


> **Note 1**: Currently, the audio extraction strictly follows subtitle
> timing.

> **Note 2**: Audio extraction currently only works with local video files.
> For video streams I recommend using free tools like [Abs Player](https://chromewebstore.google.com/detail/asbplayer-language-learni/hkledmpjpaehamkiehglnbelcpdflcab)
> that work directly in the web browser.

## Requirements
(all open-source)
- [mpv](https://mpv.io/) (or any software built on mpv like [IINA](https://iina.io/) (MacOS)) - _cross-platform media player_
- [ffmpeg](https://ffmpeg.org/) - _a suite of libraries to handle multimedia files_
- [Anki](https://apps.ankiweb.net/) - _powerful [SRS](https://en.wikipedia.org/wiki/Spaced_repetition) flashcard app_
- [AnkiConnect](https://ankiweb.net/shared/info/2055492159) - _Anki add-on_

> **Note**: _AnkiConnect add-on must be installed in Anki and Anki must be running while using this script._


## Getting Started

🚧 More detailed documentation is **coming soon** for non-technical language learners and will be available in the [docs](docs) folder.



## Contributing & Support

| Type                                                                 | Description                                      |
|----------------------------------------------------------------------|--------------------------------------------------|
| [Issues & Requests](https://github.com/alyssabedard/mpv2anki/issues) | Bug reports or feature requests                  | 
| [Contributing](.github/CONTRIBUTING.md)                              | Fork the repo and submit a PR                    |
| [Discussions](https://github.com/alyssabedard/mpv2anki/discussions)  | Getting help and questions                       |
| [Support](.github/SUPPORT.md)                                        | Support - Getting Started                        |
| Help Wanted                                                          | Need help with OS-specific documentation/testing |

## Credits
GIF: donghua (anime) 魔道祖师 (_Mo Dao Zu Shi_  |  _Grandmaster of Demonic Cultivation_  |  _The Founder of Diabolism_  |  _The Master of Diabolism_) S01:E02
- [My Anime List (MAL)](https://myanimelist.net/anime/37208/Mo_Dao_Zu_Shi)
- [Douban 豆瓣](https://movie.douban.com/subject/27015848/)

