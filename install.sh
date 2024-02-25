#!/bin/bash

set -e

# Taken from https://github.com/holman/dotfiles
# Great repo, much here is inspired from that repo!
info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

create_symlink() {
    local target=$1
    local link_name=$2

    if [ -L "$link_name" ]; then
        if [ "$(readlink "$link_name")" == "$target" ]; then
            info "Link already exists"
            return 0
        else
            rm "$link_name"
            info "Removed existing symlink: $link_name"
        fi
    elif [ -d "$link_name" ]; then
        mv "$link_name" "${link_name}.backup"
        info "Existing directory renamed to backup: ${link_name}.backup"
    fi

    ln -s "$target" "$link_name"
    success "Created new symlink: $link_name -> $target"
}

# Set up
DOTFILES_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
HOME_DIR=$HOME

# Symlink nvim
NVIM_DIR="$HOME_DIR/.config/nvim"
create_symlink "$DOTFILES_PATH/nvim" "$NVIM_DIR"

# Run all install.sh
find "$DOTFILES_PATH" -mindepth 2 -maxdepth 2 -name install.sh | while read installer; do
    installer_dir=$(basename $(dirname "$installer"))
    info "Installing $installer_dir..."

    bash "$installer"

    success "$installer_dir completed successfully."
done

# Append source command for aliases.sh to .bashrc
find "$DOTFILES_PATH" -name aliases.sh | while read alias_file; do
    if ! grep -q "source $alias_file" "$HOME_DIR/.bashrc"; then
        echo "source $alias_file" >> "$HOME_DIR/.bashrc"
        alias_dir=$(basename $(dirname "$alias_file"))
        success "$alias_dir successfully added to .bashrc"
    else
        alias_dir=$(basename $(dirname "$alias_file"))
        info "$alias_dir already sourced in .bashrc"
    fi
done

echo "Installation complete. Please restart your terminal or run 'source ~/.bashrc' to apply changes."

