# Check if the operating system is Windows
ifeq ($(OS),Windows_NT)
    # If Windows, set MPV config directory to %APPDATA%/mpv
    MPV_CONFIG_DIR := $(APPDATA)/mpv
else
    # If not Windows, get the Unix-like system name (Darwin = macOS, Linux = Linux)
    UNAME_S := $(shell uname -s)

    # If the system is macOS (Darwin)
    ifeq ($(UNAME_S),Darwin)
        # Set MPV config directory to ~/.config/mpv
        MPV_CONFIG_DIR := $(HOME)/.config/mpv

    # If the system is Linux
    else ifeq ($(UNAME_S),Linux)
        # Set MPV config directory to ~/.config/mpv
        MPV_CONFIG_DIR := $(HOME)/.config/mpv
    endif
endif

.PHONY: help sync-to-mpv \
		retag tag \
		play list open sync-and-play

help:
	@echo "=== [mpv2anki] Available commands: ==="
	@echo "  make \033[34msync-to-mpv\033[0m   	- Copy files to MPV configuration files. \033[31mWARNING: Will replace your conf files!!!!\033[0m"
	@echo "  make \033[34mhelp\033[0m         	- Show this help message"
	@echo "  make \033[34mtag\033[0m         	- Create a new tag (GitHub workflows)"
	@echo "  make \033[34mretag\033[0m         	- Delete and recreate a tag (GitHub workflows)"

# Warning: Will replace your input.conf and mpv.conf
# Remove the @cp lines according to your needs
sync-to-mpv:
	@echo "Copying MPV configuration files to $(MPV_CONFIG_DIR)"
	@mkdir -p $(MPV_CONFIG_DIR)
	@mkdir -p $(MPV_CONFIG_DIR)/scripts
	@cp -r mpv/scripts/* $(MPV_CONFIG_DIR)/scripts/
	@cp mpv/input.conf $(MPV_CONFIG_DIR)/
	@cp mpv/mpv.conf $(MPV_CONFIG_DIR)/
	@echo "\033[32m✨Done✨!\033[0m "



# Command to delete and recreate a tag
# It will prompt: Enter version (e.g., 1.0.0):
# Will delete existing tag and create new one
retag:
	@read -p "Enter version (e.g., 1.0.0): " version; \
	if [ -n "$$version" ]; then \
		echo "Deleting tag v$$version..."; \
		git push --delete origin "v$$version" 2>/dev/null || echo "Remote tag doesn't exist"; \
		git tag -d "v$$version" 2>/dev/null || echo "Local tag doesn't exist"; \
		echo "Creating new tag v$$version..."; \
		git tag "v$$version" && \
		git push origin "v$$version" && \
		echo "Successfully created and pushed tag v$$version" || \
		echo "Failed to create/push tag"; \
	else \
		echo "No version provided"; \
	fi

# Command to create a new tag
# It will prompt: Enter version (e.g., 1.0.0):
# If tag already exists, it will tell you to use retag
tag:
	@read -p "Enter version (e.g., 1.0.0): " version; \
	if [ -n "$$version" ]; then \
		if git rev-parse "v$$version" >/dev/null 2>&1; then \
			echo "Error: Tag v$$version already exists. Use 'make retag' to recreate it."; \
			exit 1; \
		else \
			echo "Creating new tag v$$version..."; \
			git tag "v$$version" && \
			git push origin "v$$version" && \
			echo "Successfully created and pushed tag v$$version" || \
			echo "Failed to create/push tag"; \
		fi \
	else \
		echo "No version provided"; \
	fi

# Variable for MPV path
MPV := /Applications/mpv.app/Contents/MacOS/mpv

# Default video path I'm using for testing my script
# Opens MPV with terminal - useful for debugging
DEFAULT_VIDEO := "$(HOME)/Movies/TV Shows and Movies/全职高手 The King's Avatar/EP1 - The King's Avatar [g0029ctql3f].mp4"
VIDEO_DIR := "$(HOME)/Movies/TV Shows and Movies/全职高手 The King's Avatar/"

play:
	$(MPV) $(if $(FILE),"$(FILE)",$(DEFAULT_VIDEO))

# List available videos in VIDEO_DIR
list:
	ls $(VIDEO_DIR)

# Open mpv and wait for drag and drop
open:
	open -a mpv


sync-and-play: sync-to-mpv play