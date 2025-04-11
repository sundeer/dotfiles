# Load the job into launchd
launchctl load ~/Library/LaunchAgents/com.rhsjmm.chezmoi.brewfile.plist

# Install Homebrew dependencies
/opt/homebre/bin/brew bundle --file="$HOME/.local/share/chezmoi/brewfile"