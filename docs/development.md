# Development

🚧 Coming Soon 🚧

### Makefile Commands

| Command            | Description                                                    | Notes                                                                            |
|--------------------|----------------------------------------------------------------|----------------------------------------------------------------------------------|
| `make sync-to-mpv` | Copy files to MPV configuration directory according to your OS | **WARNING**: Will replace your existing configuration files in the MPV directory |
| `make help`        | Display all available commands                                 | Shows descriptions for each command                                              |



### OS Paths
**Windows**
```
MEDIA_PATH = os.getenv('APPDATA') .. '\\Anki2\\User 1\\collection.media\\'
```

```
FFMPEG = {
    PATH = 'C:\\mpv\\ffmpeg.exe'
},
```

**MacOS**

**Linux**