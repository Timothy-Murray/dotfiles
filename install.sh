#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"

# Function to create symlink with backup
link_config() {
    local source="$1"
    local target="$2"
    
    # Create target directory if it doesn't exist
    mkdir -p "$(dirname "$target")"
    
    # Backup existing config if it exists and isn't already a symlink
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "Backing up existing $target to $target.backup"
        mv "$target" "$target.backup"
    fi
    
    # Remove existing symlink if it exists
    [ -L "$target" ] && rm "$target"
    
    # Create new symlink
    ln -s "$source" "$target"
    echo "Linked $source -> $target"
}

echo "Setting up dotfiles..."

# Link configs
link_config "$DOTFILES_DIR/nvim" "$CONFIG_DIR/nvim"
link_config "$DOTFILES_DIR/bashrc" "$HOME/.bashrc"
link_config "$DOTFILES_DIR/tmux.conf" "$HOME/.tmux.conf"
link_config "$DOTFILES_DIR/bash_aliases" "$HOME/.bash_aliases"

echo "Dotfiles setup complete!"
echo "You may need to restart your terminal or run 'source ~/.bashrc' for changes to take effect."
