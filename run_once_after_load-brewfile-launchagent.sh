# Load the job into launchd
# launchctl load ~/Library/LaunchAgents/com.rhsjmm.chezmoi.brewfile.plist

brew bundle --file="$HOME/.local/share/chezmoi/brewfile" --global