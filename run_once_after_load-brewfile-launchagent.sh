# Load the job into launchd
# launchctl load ~/Library/LaunchAgents/com.rhsjmm.chezmoi.brewfile.plist

/opt/homebre/bin/brew bundle --file="$HOME/.local/share/chezmoi/brewfile" --global