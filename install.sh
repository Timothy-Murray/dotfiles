#!/bin/bash

# Create .config directory if it doesn't exist
mkdir -p ~/.config

# Create symlink for Neovim config
ln -sf ~/dotfiles/nvim ~/.config/nvim

echo "Neovim dotfiles linked successfully!"
