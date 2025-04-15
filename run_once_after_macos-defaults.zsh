#!/bin/zsh

echo "Applying macOS defaults settings..."

# === Dock Settings ===
echo "Configuring Dock..."

# Automatically hide and show the Dock
defaults write com.apple.dock "autohide" -bool "true"

# Remove autohide Dock delay
defaults write com.apple.dock "autohide-delay" -float "0"

# Autohide Dock animation speed
defaults write com.apple.dock "autohide-time-modifier" -float "0.5"

# Scroll up on a Dock icon to show all Space's opened windows for an app, or open stack.
defaults write com.apple.dock "scroll-to-open" -bool "true" 

# Dock size (pixels)
defaults write com.apple.dock "tilesize" -int "45" 

# Set Dock to show only static (pinned) apps (hiding recent/running apps)
defaults write com.apple.dock "static-only" -bool "true" 

killall Dock


# === Finder Settings ===
echo "Configuring Finder..."

# Show hidden files in Finder
defaults write com.apple.finder "AppleShowAllFiles" -bool "true"  

#  Show Finder path bar
defaults write com.apple.finder "ShowPathbar" -bool "true" 

#  Set Finder default view style to column view
defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv" 

#  Sort folders first in Finder
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true" 

#  Delete FinderSpawnTab setting to reset behavior
defaults delete com.apple.finder "FinderSpawnTab"

#  Disable automatic tab spawning in Finder
defaults write com.apple.finder "FinderSpawnTab" -bool "false" 

#  Set Finder search scope to the current folder
defaults write com.apple.finder "FXDefaultSearchScope" -string "SCcf" 

#  Enable automatic removal of old Trash items in Finder
defaults write com.apple.finder "FXRemoveOldTrashItems" -bool "true" 

#  Globally show all hidden files
defaults write -g AppleShowAllFiles -bool true

# Set Finder view style to column view
defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"

# Keep folders on top when sorting
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"

# No warning when changing file extensions
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"

# Show the status bar in Finder (remaining space)
defaults write com.apple.finder ShowStatusBar -bool "true" 

# Hide external hard drives on the desktop
defaults write com.apple.finder "ShowExternalHardDrivesOnDesktop" -bool "false"

# Hide removable media on the desktop
defaults write com.apple.finder "ShowRemovableMediaOnDesktop" -bool "false"

killall Finder


# === Screenshot Settings ===
echo "Configuring Screenshot settings..."

# Set screenshot save location to "/Users/rs/Library/CloudStorage/Dropbox/RS/Screenshots" and restart SystemUIServer
defaults write com.apple.screencapture "location" -string "/Users/rs/Library/CloudStorage/Dropbox/RS/Screenshots" 

# Disable screenshot thumbnail preview
defaults write com.apple.screencapture "show-thumbnail" -bool "false"

killall SystemUIServer


# === Global System Settings ===
echo "Configuring Global System Settings..."

# Show all file extensions system-wide in Finder
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"

# Disable press-and-hold for keys to enable key repeat
defaults write NSGlobalDomain "ApplePressAndHoldEnabled" -bool "false"

# Enable function keys to act as standard function keys
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true

# Set a fast key repeat rate system-wide
defaults write NSGlobalDomain KeyRepeat -int 1

# Set a fast initial key repeat rate
defaults write NSGlobalDomain "InitialKeyRepeat" -int 15

# Set font smoothing level to 1
defaults write NSGlobalDomain AppleFontSmoothing -int 1

# Set mouse speed to 1.5
defaults write NSGlobalDomain com.apple.mouse.scaling -float "1.5"


# === Terminal Settings ===
echo "Configuring Terminal Settings..."

# Enable focus-follows-mouse behavior in Terminal
defaults write com.apple.Terminal "FocusFollowsMouse" -bool "true" 

killall Terminal


# === Activity Monitor Settings ===
echo "Configuring Activity Monitor Settings..."

# Set Activity Monitor Dock icon to display as a graph (IconType 5)
defaults write com.apple.ActivityMonitor "IconType" -int "5"

killall Activity\ Monitor


# === Trackpad Settings ===
echo "Configuring Trackpad settings..."

# Enable Three Finger Drag
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

# Enable Tap to Click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Enable Right Click (Two Finger Click)
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true


echo "✅ All settings have been applied!"