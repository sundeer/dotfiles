#!/bin/zsh
# This script installs prezto into ~/.config/zsh/.zprezto if it is not already installed.

if [ ! -d "${$HOME}/.config/zsh/.zprezto" ]; then
  echo "Cloning prezto..."
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${$HOME}/.config/zsh/.zprezto"
fi