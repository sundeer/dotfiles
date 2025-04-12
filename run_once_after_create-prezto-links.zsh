#!/bin/zsh
# filepath: /Users/rs/.local/share/chezmoi/run_once_after_create-prezto-links.zsh

# Redirect all stdout to stderr for consistent logging.
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

# Log the start of the linking process.
Log "Starting creation of Prezto runcom symbolic links."

# Enable extended globbing options in zsh.
setopt EXTENDED_GLOB

# Loop through all runcom files except README.md.
# ${rcfile:t} removes the directory portion, yielding just the filename.
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  # Define the target path for the symbolic link.
  target="${ZDOTDIR:-$HOME}/.${rcfile:t}"
  
  Log "Creating symbolic link for: $rcfile -> $target"
  
  # Check if the target already exists; if so, skip linking.
  if [ -e "$target" ]; then
    Log "Target $target already exists; skipping."
  else
    # Attempt to create the symbolic link.
    if ln -s "$rcfile" "$target"; then
      Log "Symbolic link created successfully: $target"
    else
      exitOnError "Failed to create symbolic link for $rcfile"
    fi
  fi
done

Log "Completed creation of Prezto runcom symbolic links."