# mpv2anki - Technical Documentation
> ⚠️ **Note:** Restart MPV after making any changes to configuration files or scripts for the changes to take effect.

Please read [Quick Start Guide](../quick_start_guide.md) first.

## Requirements
- [Make](https://en.wikipedia.org/wiki/Make_(software))


## Makefile Commands Reference

| Command              | Description                                 | Key Considerations                                                                                                                                                  |
|----------------------|---------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `make sync-to-mpv`   | Copies configuration files to MPV directory | ⚠️ **WARNING**: Will override existing MPV configuration files. Comment out `@cp` lines in Makefile before running if you want to preserve specific configurations. |
| `make play`          | Opens MPV with terminal debugging enabled   | Set correct video path in `DEFAULT_VIDEO` variable. Uses `/Applications/mpv.app/Contents/MacOS/mpv` by default.                                                     |
| `make list`          | Lists available videos in VIDEO_DIR         | Requires setting correct `VIDEO_DIR` path for your system.                                                                                                          |
| `make open`          | Opens MPV and waits for drag and drop       | Simple way to test MPV without specific video path.                                                                                                                 |
| `make sync-and-play` | Combines sync-to-mpv and play commands      | Same warnings as individual commands apply.                                                                                                                         |
| `make tag`           | Creates a new Git tag                       | Used for releases. Will fail if tag exists.                                                                                                                         |
| `make retag`         | Deletes and recreates a Git tag             | Used to update existing release tags.                                                                                                                               |
| `make help`          | Shows available commands                    | Displays colored help message with command descriptions.                                                                                                            |

## Important Configuration Notes

### Path Configuration

1. **MPV Path**:
    - Default: `/Applications/mpv.app/Contents/MacOS/mpv` (macOS)
    - Modify `MPV :=` variable according to your OS:
        - Windows: typically `C:/Program Files/mpv/mpv.exe`
        - Linux: typically `/usr/bin/mpv`

2. **Video Directory**:
    - Default: `$(HOME)/Movies/TV Shows and Movies/.....` (any video path name that is on your local machine)
    - Modify `VIDEO_DIR :=` variable to point to your test video directory
    - Change `DEFAULT_VIDEO :=` to point to a specific test video file

3. **Configuration Directory**:
    - Automatically set based on OS:
        - Windows: `%APPDATA%/mpv`
        - macOS/Linux: `~/.config/mpv`
    - Only modify `MPV_CONFIG_DIR` if your setup uses non-standard paths

#### Summary
| OS | MPV Application Location                                                            | Config File Location |
|----------|-------------------------------------------------------------------------------------|-------------------|
| Windows | `C:\Program Files\mpv`                                                              | `%APPDATA%\mpv\mpv.conf` |
| macOS (Homebrew) | `/usr/local/bin/mpv`                                                                | `~/.config/mpv/mpv.conf` |
| macOS (Manual) | Finder:`/Applications/mpv.app` terminal: `/Applications/mpv.app/Contents/MacOS/mpv` | `~/.config/mpv/mpv.conf` |
| Linux | `/usr/bin/mpv`                                                                      | `~/.config/mpv/mpv.conf` |

Notes:
- macOS has two common locations depending on installation method:
   - Homebrew installs to `/usr/local/bin/mpv`
   - Manual installation goes to `/Applications/mpv.app` (drag and drop file to `Applications` folder)
- The config file location stays the same regardless of how MPV is installed on macOS
- Windows config typically expands to `C:\Users\YourUsername\AppData\Roaming\mpv\`
- Windows mpv path needs to be declared in system PATH



### Debug Mode

To test MPV with terminal debugging:
1. Run `make play` to launch MPV with debug output enabled (make sure to change the mpv (video player) path...)
2. Debug messages will be visible in the terminal
3. Use `--msg-level=mpv2anki=debug` flag for detailed logging

### Safety Considerations

1. **Before Running `sync-to-mpv`**:
    - Backup your existing MPV configuration files
    - Review the `@cp` commands in Makefile
    - Comment out any `@cp` lines for configurations you want to preserve
    - Configuration files that will be overwritten:
        - `input.conf`
        - `mpv.conf`
        - Files in `scripts/` directory
        - Files in `script-opts/` directory

### Release Management

1. **Creating a New Release**:
   ```bash
   make tag    # Prompts for version number (e.g., 1.0.0)
   ```
   - Creates and pushes a new Git tag
   - Fails if tag already exists

2. **Updating a Release**:
   ```bash
   make retag  # Prompts for version number
   ```
   - Deletes existing tag (both local and remote)
   - Creates and pushes new tag with same version
   - Use when need to update an existing release
