brew bundle dump --force --file=~/.local/share/chezmoi/dot_config/Brewfile

chezmoi git add ./dot_config/Brewfile
chezmoi git -- commit -m "Modified: Brewfile"
chezmoi apply
chezmoi git push
