#!/bin/bash

# This script dumps the Brewfile and updates the chezmoi repository.
# It adds error handling for each step, reporting to stdout and stderr.

# Step 1: Dump Brewfile using brew bundle dump
echo "Dumping Brewfile..."
if brew bundle dump --force --file="/Users/rs/.local/share/chezmoi/dot_config/Brewfile"; then
    echo "Brewfile dumped successfully."
else
    echo "Error: Failed to dump Brewfile." >&2
    exit 1
fi

# Step 2: Stage the Brewfile changes with chezmoi
echo "Adding Brewfile to chezmoi git..."
if chezmoi git add ./dot_config/Brewfile; then
    echo "Brewfile added successfully."
else
    echo "Error: Failed to add Brewfile with chezmoi git." >&2
    exit 1
fi

# Step 3: Commit the changes
echo "Committing changes..."
if chezmoi git -- commit -m "Modified: Brewfile"; then
    echo "Changes committed successfully."
else
    echo "Error: Failed to commit changes." >&2
    exit 1
fi

# Step 4: Apply the changes using chezmoi
echo "Applying changes using chezmoi..."
if chezmoi apply; then
    echo "Changes applied successfully."
else
    echo "Error: Failed to apply changes with chezmoi." >&2
    exit 1
fi

# Step 5: Push the changes to the remote repository
echo "Pushing changes to remote repository..."
if chezmoi git push; then
    echo "Changes pushed successfully."
else
    echo "Error: Failed to push changes with chezmoi git." >&2
    exit 1
fi

# Step 6: Apply the changes to the target directory
echo "Applying changes to target directory..."
if chezmoi apply; then
    echo "Changes applied successfully."
else
    echo "Error: Failed to apply changes to target." >&2
    exit 1
fi

exit 0