#!/bin/zsh

# Prompt the user for the base computer name
read "COMP_NAME?Enter the computer's name (no spaces): "

# Prompt the user for a domain name (optional)
read "DOMAIN_NAME?Enter the domain name (e.g., example.com): "

# Safety check: replace spaces with hyphens for LocalHostName
CLEAN_LOCAL_NAME="${COMP_NAME// /-}"

echo "\nSetting names to '$COMP_NAME' with domain '$DOMAIN_NAME'..."

# Set HostName (used by low-level UNIX services and networking)
# Appends the domain if provided
if [[ -n "$DOMAIN_NAME" ]]; then
  sudo scutil --set HostName "$COMP_NAME.$DOMAIN_NAME"
else
  sudo scutil --set HostName "$COMP_NAME"
fi

# Set ComputerName (user-friendly name shown in Finder, AirDrop, etc.)
sudo scutil --set ComputerName "$COMP_NAME"

# Set LocalHostName (Bonjour name, used in .local networking)
sudo scutil --set LocalHostName "$CLEAN_LOCAL_NAME"

# Set NetBIOSName (used by SMB for Windows sharing compatibility)
# This goes into the smb server config file
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$COMP_NAME"

# Feedback
echo "\n✅ Host names updated:"
echo "  HostName:       $(scutil --get HostName)"
echo "  ComputerName:   $(scutil --get ComputerName)"
echo "  LocalHostName:  $(scutil --get LocalHostName)"
echo "  NetBIOSName:    $(defaults read /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName)"

echo "\nDone! You may need to restart sharing services or reboot for all changes to fully apply."