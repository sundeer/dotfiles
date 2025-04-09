#!/bin/bash

timestamp() {
    date '+%Y-%m-%d %H:%M:%S'
}

# This script dumps the Brewfile and updates the chezmoi repository.
# It adds error handling for each step, reporting to stdout and stderr.

# Step 1: Dump Brewfile using brew bundle dump
echo "$(timestamp) Dumping Brewfile..."
if /opt/homebrew/bin/brew bundle dump --force --file="/Users/rs/.local/share/chezmoi/dot_config/Brewfile"; then
    echo "$(timestamp) Brewfile dumped successfully."
else
    echo "$(timestamp) Error: Failed to dump Brewfile." >&2
    exit 1
fi

# Step 2: Stage the Brewfile changes with chezmoi
echo "$(timestamp) Adding Brewfile to chezmoi git..."
if chezmoi git add ./dot_config/Brewfile; then
    echo "$(timestamp) Brewfile added successfully."
else
    echo "$(timestamp) Error: Failed to add Brewfile with chezmoi git." >&2
    exit 1
fi

# Step 3: Commit the changes
echo "$(timestamp) Committing changes..."
if chezmoi git -- commit -m "Modified: Brewfile"; then
    echo "$(timestamp) Changes committed successfully."
else
    echo "$(timestamp) Error: Failed to commit changes." >&2
    exit 1
fi

# Step 4: Apply the changes using chezmoi
echo "$(timestamp) Applying changes using chezmoi..."
if chezmoi apply; then
    echo "$(timestamp) Changes applied successfully."
else
    echo "$(timestamp) Error: Failed to apply changes with chezmoi." >&2
    exit 1
fi

# Step 5: Push the changes to the remote repository
echo "$(timestamp) Pushing changes to remote repository..."
if chezmoi git push; then
    echo "$(timestamp) Changes pushed successfully."
else
    echo "$(timestamp) Error: Failed to push changes with chezmoi git." >&2
    exit 1
fi

# Step 6: Apply the changes to the target directory
echo "$(timestamp) Applying changes to target directory..."
if chezmoi apply; then
    echo "$(timestamp) Changes applied successfully."
else
    echo "$(timestamp) Error: Failed to apply changes to target." >&2
    exit 1
fi

exit 0