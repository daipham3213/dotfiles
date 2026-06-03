#!/usr/bin/bash

set -e

REPO_URL="https://github.com/daipham3213/dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"

echo "=============="
echo "Dotfiles Setup"
echo "=============="

# is git installed?
if ! command -v git &> /dev/null; then
    echo "try installing git..."
    if command -v pacman &> /dev/null; then
        sudo pacman -S git --noconfirm
    else
        echo "unsupported package manager, please install git manually"
        exit 1
    fi
fi

# clone the repository if it doesn't exist
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "cloning dotfiles repository..."
    git clone "$REPO_URL" "$DOTFILES_DIR"
else
    echo "dotfiles repository already exists, pulling latest changes..."
    git -C "$DOTFILES_DIR" pull
fi

# run the install script
if [ -f "$DOTFILES_DIR/install.sh" ]; then
    echo "running install script..."
    bash "$DOTFILES_DIR/installers/install"
else
    echo "install script not found, please check the repository"
    exit 1
fi
