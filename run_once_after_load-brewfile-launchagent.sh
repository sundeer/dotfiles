#!/bin/bash

# Load the job into launchd
launchctl load ~/Library/LaunchAgents/com.rhsjmm.chezmoi.brewfile.plist

# Install Homebrew dependencies
/opt/homebrew/bin/brew bundle --file="$HOME/.local/share/chezmoi/brewfile"