#!/bin/sh

# this file is for installing dotfiles in devcontainer/codespace using yadm
if [ -z "$USER" ]; then
  USER=$(id -un)
fi

cd $HOME

# remove oh my zsh
~/.oh-my-zsh/tools/uninstall.sh
rm -rf .oh-my-zsh
rm .zshrc
rm .zshenv
rm .zprofile

# Make passwordless sudo work
export SUDO_ASKPASS=/bin/true

# Install ripgrep for fast searching
sudo apt-get install ripgrep

# Install yadm for managing dotfiles
sudo apt-get update
sudo apt-get install -y yadm
yadm clone -f https://github.com/danielnolan/dotfiles
yadm sparse-checkout set --no-cone '/*' '!README.md' '!LICENSE'

rm -rf dotfiles

# ensure zsh is still default shell
sudo chsh -s $(which zsh) $USER
