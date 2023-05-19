#!/bin/bash

function install_packages() {
    # Install zsh and set it as the default shell.
    sudo pacman -S --noconfirm zsh
    chsh -s $(which zsh)

    # Install oh-my-zsh.
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    # Install Neovim and Kitty.
    sudo pacman -S --noconfirm neovim kitty

    # Install google-chrome.
    paru -S --noconfirm google-chrome
}

function install_optional_dependencies() {
    # Install powerline-fonts for the agnoster theme of zsh.
    sudo pacman -S --noconfirm powerline-fonts

    # Install zsh-syntax-highlighting and zsh-autosuggestions.
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

    # Install Packer for Neovim.
    paru -S --noconfirm nvim-packer-git

    # Install JetBrains Mono nerd font.
    sudo pacman -S --noconfirm ttf-jetbrains-mono-nerd
}

function setup_dotfiles() {
    # Install and set up chezmoi and dotfiles.
    sudo pacman -S --noconfirm chezmoi
    chezmoi init --apply https://github.com/joseph-amirth/.dotfiles.git
}

install_packages
install_optional_dependencies
setup_dotfiles
