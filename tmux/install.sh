#!/bin/bash

if [[ -d ~/.tmux/plugins/tpm ]]; then
    echo "Directory ~/.tmux/plugins/tpm already exists, assuming tpm is already installed"
else
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Get the directory where this script is located
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

tmux_conf_source="$script_dir/.tmux.conf"
tmux_conf_target="$HOME/.tmux.conf"

if [ ! -f "$tmux_conf_source" ]; then
    echo "Error: .tmux.conf file not found in the script's directory."
    exit 1
fi

if [ -f "$tmux_conf_target" ]; then
    # Regular file: back it up
    echo "Backing up existing .tmux.conf to .tmux.conf.backup"
    mv "$tmux_conf_target" "$tmux_conf_target.backup"
elif [ -L "$tmux_conf_target" ]; then
    # Existing symlink: remove it
    echo "Removing existing symlink at .tmux.conf"
    rm "$tmux_conf_target"
fi

# Create the symlink
echo "Creating symlink to $tmux_conf_source"
ln -s "$tmux_conf_source" "$tmux_conf_target"

