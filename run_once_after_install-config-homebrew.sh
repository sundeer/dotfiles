#!/bin/bash

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

# Install Homebrew
Log "Installing Homebrew..."
if command -v brew >/dev/null 2>&1; then
    Log "Homebrew is already installed."
else
    if /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
        exitOnError "Failed to install Homebrew."
    fi
    Log "Homebrew installed successfully."
fi

# Install Homebrew dependencies
Log "Checking for Homebrew dependencies..."
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

# Load Homebrew launchd job
Log "Loading Homebrew launchd job..."
Log "Checking for existing launchd job..."
if launchctl list | grep -q "com.rhsjmm.chezmoi.brewfile"; then
    Log "Launchd job plist file found."

    Log "Loading launchd job..."
    if launchctl load ~/Library/LaunchAgents/com.rhsjmm.chezmoi.brewfile.plist; then
        Log "Launchd job loaded successfully."
    else
        exitOnError "Failed to load launchd job: ~/Library/LaunchAgents/com.rhsjmm.chezmoi.brewfile.plist"
fi
else
    exitOnError "Launchd job plist file not found."
fi

