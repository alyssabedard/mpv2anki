# Installation

### Notes for now:
- The current note type configurations can be found in `scripts/mpv2anki/modules/ankiconnect.lua`
  and `scripts/mpv2anki/config.lua`

- mpv keybindings can be found inside `input.conf`, `scripts/mpv2anki/config.lua`
  and `scripts/mpv2anki/main.lua`
- When setting up your MPV keybindings in `input.conf`, feel free to customize
  them to your preferences. However, make sure to review both `main.lua` and `config.lua`
  to ensure your changes don't conflict with the script's functionality.


# Usage
### Default mpv Keybindings

| Key       | Command                            | Description               | 
|-----------|------------------------------------|---------------------------|
| `Shift+d` | `script-binding pause-and-capture` | Pause and capture to Anki |
| `Shift+h` | `script-binding show-commands`     | Show all commands         |

> **Note**: You can customize these keybindings in your MPV configuration,
> but make sure to check `main.lua` and `config.lua` to avoid conflicts with
> the script's functionality. This also applies to MPV-based media players like IINA (check the software settings).


