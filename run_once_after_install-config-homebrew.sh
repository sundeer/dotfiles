#!/bin/bash

# Redirect all stdout to stderr
exec 1>&2

# Function to generate a timestamp for logs.
timestamp() {
    date '+%Y-%m-%d %H:%M:%S'
}

# Function for logging messages with timestamps.
Log() {
    echo "[$(timestamp)] LOG: $1"
}

# Function to log errors and exit.
exitOnError() {
    echo "[$(timestamp)] ERROR: $1"
    exit 1
}

# ------------------------
# Install Homebrew Section
# ------------------------
Log "Installing Homebrew..."
if brew >/dev/null 2>&1; then
    Log "Homebrew is already installed."
else
    if /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
        Log "Homebrew installed successfully."
    else
        exitOnError "Failed to install Homebrew."
    fi
fi

# -------------------------------------
# Install Homebrew Dependencies Section
# -------------------------------------
Log "Checking for Homebrew dependencies..."
if [ "$CI" = "true" ]; then
    # In CI mode, do not install packages, just list dependencies.
    Log "CI environment detected, listing Homebrew dependencies..."
    if /opt/homebrew/bin/brew bundle list --file="$HOME/.config/homebrew/Brewfile"; then
        Log "Brew bundle list executed successfully in CI environment."
    else
        exitOnError "Failed to list Homebrew dependencies from Brewfile in CI environment."
    fi
else
    # In non-CI, install the dependencies.
    Log "Installing Homebrew dependencies..."
    if /opt/homebrew/bin/brew bundle --file="$HOME/.config/homebrew/Brewfile"; then
        Log "Homebrew dependencies installed successfully."
    else
        exitOnError "Failed to install Homebrew dependencies from Brewfile."
    fi
fi

# -------------------------------
# Load Homebrew Launchd Job Section
# -------------------------------
Log "Loading Homebrew launchd job..."
if launchctl list | grep -q "com.rhsjmm.chezmoi.brewfile"; then
    Log "Launchd job already loaded."
else
    if launchctl load ~/Library/LaunchAgents/com.rhsjmm.chezmoi.brewfile.plist; then
        Log "Launchd job loaded successfully."
    else
        exitOnError "Failed to load launchd job: ~/Library/LaunchAgents/com.rhsjmm.chezmoi.brewfile.plist"
    fi
fi

