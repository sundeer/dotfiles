#!/bin/bash
# filepath: /Users/rs/.local/share/chezmoi/run_once_before_homebrew-install.sh

if command -v brew >/dev/null 2>&1; then
    echo "Homebrew is already installed."
else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

