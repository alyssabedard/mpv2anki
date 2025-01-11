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

.PHONY: help sync-to-mpv

help:
	@echo "=== [mpv2anki] Available commands: ==="
	@echo "  make \033[34msync-to-mpv\033[0m   	- Copy files to MPV configuration files. \033[31mWARNING: Will replace your conf files!!!!\033[0m"
	@echo "  make \033[34mhelp\033[0m         	- Show this help message"

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

