<div align="center">
<h1 style="font-family: monospace;">mpv2anki</h1>
<a href="https://github.com/alyssabedard/mpv2anki/releases"><img src="https://img.shields.io/github/v/release/alyssabedard/mpv2anki?style=for-the-badge&labelColor=%231C1C1C&color=%23A692E3&logo=github" /></a>
<br>   
<div>
<img src="docs/screenshots/demo3.png" width="1000" alt="Demo of MPV to Anki"/>
</div>   
</div>

## Description
A simple script to assist your language learning journey in any language by automatically capturing multimedia content from [mpv](https://mpv.io/) to [Anki](https://apps.ankiweb.net/).
It extracts the current subtitles (target language and native/secondary language), corresponding audio,
and screenshot when triggered, making it easy to create flashcards.


> _Need help? Want to raise an issue? Looking for documentation? See [Contributing & Support](#contributing--support)_


## Features

1. [x] Automatically create Anki cards with extracted content
   1. [x] Extract current subtitle text from MPV
   2. [x] Capture audio segment corresponding to subtitle timing
   3. [x] Take screenshots at current playback position
2. [x] Field mapping configurations 

### Planned Features

| Feature                        | Sub-feature                                                                                  | Notes |
|--------------------------------|----------------------------------------------------------------------------------------------|-------|
| Custom audio segment selection | Set custom start and end points for audio clips independent of subtitle timing               | 1     |
| Quick card creation            | Create cards directly without opening the editor window                                      |       |
| Documentation                  | IINA set-up                                                                                  |       |
| Audio extraction               | URL/Video stream support (platforms supported by [yt-dlp](https://github.com/yt-dlp/yt-dlp)) | 2     |
| Field mapping                  | Video filename mapping for `[config.ANKI.FIELDS.SOURCE]`                                     |       |

> **Note 1**: Currently, the audio extraction strictly follows subtitle
> timing.

> **Note 2**: Audio extraction currently only works with local video files.
> For video streams I recommend using free tools like [Abs Player](https://chromewebstore.google.com/detail/asbplayer-language-learni/hkledmpjpaehamkiehglnbelcpdflcab)
> that work directly in the web browser.

## Requirements
(all open-source)
- [mpv](https://mpv.io/) (or any software built on mpv like [IINA](https://iina.io/)) - _cross-platform media player_
- [ffmpeg](https://ffmpeg.org/) - _a suite of libraries to handle multimedia files_
- [Anki](https://apps.ankiweb.net/) - _powerful [SRS](https://en.wikipedia.org/wiki/Spaced_repetition) flashcard app_
- [AnkiConnect](https://ankiweb.net/shared/info/2055492159) - _Anki add-on_

> **Note**: _AnkiConnect add-on must be installed in Anki and Anki must be running while using this script._


## Demo
<div align="center"><br>
   <img src="docs/screenshots/demo.gif" width="1000" alt="Demo of MPV to Anki"/>
</div>


## Contributing & Support

| Type                                                                 | Description                        |
|----------------------------------------------------------------------|------------------------------------|
| [Issues & Requests](https://github.com/alyssabedard/mpv2anki/issues) | Bug reports or feature requests    | 
| [Contributing](.github/CONTRIBUTING.md)                              | Fork the repo and submit a PR      |
| [Discussions](https://github.com/alyssabedard/mpv2anki/discussions)  | Getting help and questions         |
| [Support](.github/SUPPORT.md)                                        | Support                            |
| [Quick Start Guide](docs/quick_start_guide.md)                       | Quick Start Guide                  |
| [Technical documentation](docs/dev)                                  | Technical documentation            |
| Help Wanted                                                          | Need help with OS-specific testing |

_This script has been primarily tested on macOS and Windows.  I currently don't have 
access to a Linux machine for thorough testing._

## Acknowledgements

While not a direct fork, this project acknowledges [mpv2anki](https://github.com/SenneH/mpv2anki), 
an earlier Linux-specific implementation with similar goals that appears to be no longer maintained.




