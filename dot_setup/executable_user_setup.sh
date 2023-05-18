#!/bin/bash

function install_prereqs() {
    # To make makepkg work.
    sudo pacman -S --noconfirm base-devel

    # Install git.
    sudo pacman -S --noconfirm git
}

function install_packages() {
    # Install zsh and set it as the default shell.
    sudo pacman -S --noconfirm zsh
    chsh -s $(which zsh)

    # Install oh-my-zsh.
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    # Install Neovim and Kitty.
    sudo pacman -S --noconfirm neovim kitty

    # Install google-chrome.
    sudo paru -S --noconfirm google-chrome
}

function install_dependencies() {
    # Install powerline-fonts for the agnoster theme of zsh.
    sudo pacman -S --noconfirm powerline-fonts

    # Install zsh-syntax-highlighting and zsh-autosuggestions.
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

    # Install Packer for Neovim.
    sudo paru -S --noconfirm nvim-packer-git

    # Install JetBrains Mono.
    sudo paru -S --noconfirm ttf-jetbrains-mono-git
}

function setup_dotfiles() {
    # Install and set up chezmoi and dotfiles.
    sudo pacman -S --noconfirm chezmoi
    chezmoi init --apply https://github.com/joseph-amirth/.dotfiles.git
}

install_prereqs
install_packages
install_dependencies
setup_dotfiles
