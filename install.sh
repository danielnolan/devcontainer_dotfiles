#!/bin/sh

# this file is for installing dotfiles in devcontainer/codespace using yadm
if [ -z "$USER" ]; then
  USER=$(id -un)
fi

cd $HOME

# Make passwordless sudo work
export SUDO_ASKPASS=/bin/true

# remove oh my zsh if it exists in the devcontainer image
rm .zshrc
rm .zprofile
rm -rf .oh-my-zsh

# Update apt package cache
sudo apt-get update

# Install yadm for managing dotfiles
sudo apt-get install -y yadm
yadm clone -f https://github.com/danielnolan/dotfiles.git --bootstrap
yadm sparse-checkout set --no-cone '/*' '!README.md' '!LICENSE'
yadm remote set-url origin git@github.com:danielnolan/dotfiles.git

rm -rf dotfiles

# ensure zsh is still default shell
sudo chsh -s $(which zsh) $USER
