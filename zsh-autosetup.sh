#!/bin/bash

echo "---------------------------------------"
echo "Installing zsh..."
echo "---------------------------------------"

sudo apt update
sudo apt install zsh

if ! zsh --version; then
    echo "---------------------------------------"
    echo "Error installing zsh, exiting"
    echo "---------------------------------------"
    exit 1
fi

# echo "Setting zsh as default shell..."

# chsh -s "$(which zsh)"

echo "---------------------------------------"
echo "Installing oh-my-zsh..."
echo "You will need to exit from the"
echo "oh-my-zsh shell so this script can"
echo "continue."
echo "---------------------------------------"

if ! curl --version; then
    echo "---------------------------------------"
    echo "Need curl to download oh-my-zsh"
    echo "---------------------------------------"
    sudo apt install curl
fi

if ! git --version; then
    echo "---------------------------------------"
    echo "Need git to download oh-my-zsh"
    echo "---------------------------------------"
    sudo apt install git
fi

if ! sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; then
    echo "---------------------------------------"
    echo "Error installin oh-my-zsh, exiting"
    echo "---------------------------------------"
    exit 1
fi

cp ./bira-own.zsh-theme ~/.oh-my-zsh/themes/

sed -i "s/^ZSH_THEME=.*$/ZSH_THEME=\"bira-own\"/" ~/.zshrc

echo "---------------------------------------"
echo "zsh setup complete!"
echo "Log out and back in, njoy"
echo "---------------------------------------"
