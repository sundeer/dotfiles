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

# This script dumps the Brewfile and updates the chezmoi repository.
# It adds error handling for each step, reporting exclusively to stderr.

echo ""
Log "Starting ChezMoi Brewfile dump and apply process"

# Dump Brewfile using brew bundle dump (swallow stdout)
Log "Dumping Brewfile..."
if brew bundle dump --force --file="${HOME}/.local/share/chezmoi/dot_config/Brewfile"; then
    Log "Brewfile dumped successfully."
else
    exitOnError "Failed to dump Brewfile."
fi

# Stage the Brewfile changes with chezmoi (swallow stdout)
Log "Adding Brewfile to chezmoi git..."
if chezmoi git add ./dot_config/Brewfile; then
    Log "Brewfile added successfully."
else
    exitOnError "Failed to add Brewfile with chezmoi git."
fi

# Commit the changes (swallow stdout)
Log "Committing changes..."
if chezmoi git -- commit -m "Modified: Brewfile"; then
    Log "Changes committed successfully."
else
    exitOnError "Failed to commit changes."
fi

# Push the changes to the remote repository (swallow stdout)
Log "Pushing changes to remote repository..."
if chezmoi git push; then
    Log "Changes pushed successfully."
else
    exitOnError "Failed to push changes with chezmoi git."
fi

# Apply the changes to the target directory (swallow stdout)
Log "Applying changes to target directory..."
if chezmoi apply; then
    Log "Changes applied successfully."
else
    exitOnError "Failed to apply changes to target."
fi

Log "ChezMoi Brewfile dump and apply completed successfully."

exit 0