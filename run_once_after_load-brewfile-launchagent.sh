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

# ---------------------------
# Launchd job loading
# ---------------------------
Log "Loading launchd job..."
if launchctl load ~/Library/LaunchAgents/com.rhsjmm.chezmoi.brewfile.plist; then
    Log "Launchd job loaded successfully."
else
    exitOnError "Failed to load launchd job: ~/Library/LaunchAgents/com.rhsjmm.chezmoi.brewfile.plist"
fi

# ----------------------------------
# Homebrew operations
# ----------------------------------
if [ "$CI" = "true" ]; then
    # In CI mode, do not install packages, just list Homebrew dependencies.
    Log "CI environment detected, listing Homebrew dependencies..."
    if /opt/homebrew/bin/brew bundle list --file="$HOME/.config/homebrew/Brewfile"; then
        Log "Brew bundle list executed successfully in CI environment."
    else
        exitOnError "Failed to list Homebrew dependencies from Brewfile in CI environment."
    fi
else
    # In a non-CI environment, install Homebrew dependencies.
    Log "Installing Homebrew dependencies..."
    if /opt/homebrew/bin/brew bundle --file="$HOME/.config/homebrew/Brewfile"; then
        Log "Homebrew dependencies installed successfully."
    else
        exitOnError "Failed to install Homebrew dependencies from Brewfile."
    fi
fi