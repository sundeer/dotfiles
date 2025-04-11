#!/bin/bash
# filepath: /Users/rs/.local/share/chezmoi/run_once_after_load-brewfile-launchagent.sh

exec 1>&2

timestamp() {
    date '+%Y-%m-%d %H:%M:%S'
}

Log() {
    echo "[$(timestamp)] LOG: $1"
}

exitOnError() {
    echo "[$(timestamp)] ERROR: $1"
    exit 1
}

Log "Loading launchd job..."
if launchctl load ~/Library/LaunchAgents/com.rhsjmm.chezmoi.brewfile.plist; then
    Log "Launchd job loaded successfully."
else
    exitOnError "Failed to load launchd job: ~/Library/LaunchAgents/com.rhsjmm.chezmoi.brewfile.plist"
fi

Log "Installing Homebrew dependencies..."
if /opt/homebrew/bin/brew bundle --file="$HOME/.local/share/chezmoi/brewfile"; then
    Log "Homebrew dependencies installed successfully."
else
    exitOnError "Failed to install Homebrew dependencies from brewfile."
fi