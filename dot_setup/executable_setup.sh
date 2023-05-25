#!/bin/bash
# Bash script to setup desktop environment in Arch.

# ANSI escape codes for colors
red='\033[31m'
green='\033[32m'
blue='\033[34m'
reset='\033[0m'

# Echo wrappers.
function infoln() {
    echo -e "${blue}$1${reset}"
}

function successln() {
    echo -e "${green}$1${reset}"
}

function errorln() {
    echo -e "${red}$1${reset}"
}

function wait_for_internet_connection() {
    # Wait for internet connection to be established.
    while ! ping -c1 8.8.8.8 &> /dev/null
    do
        echo "Ping failed - trying again in 1 second(s)."
        echo "Check internet connection."
        sleep 1
    done
    
    echo "Internet connection established."
}

function install_prerequisites() {
    # To install AUR packages and for chezmoi.
    sudo pacman -S --noconfirm git

    # To make makepkg work.
    sudo pacman -S --noconfirm base-devel

    # Install rust for paru (AUR helper).
    sudo pacman -S --noconfirm rustup
    rustup default stable

    # Install python and PIP for ranger.
    sudo pacman -S --noconfirm python python-pip
}

function install_aur_helper() {
    # Install paru (AUR helper).
    git clone https://aur.archlinux.org/paru.git ~/aurtemp
    cd ~/aurtemp
    makepkg --syncdeps
    sudo pacman -U --noconfirm *.pkg.tar.zst
    cd ~ && rm -rf ~/aurtemp
}

function install_de() {
    # Install X and GPU drivers.
    sudo pacman -S --noconfirm xorg nvidia-open

    # Install and enable display manager.
    sudo pacman -S lightdm lightdm-slick-greeter
    sudo systemctl enable lightdm.service

    # Install window manager and composite manager.
    sudo pacman -S --noconfirm bspwm sxhkd rofi polybar feh
    paru -S --noconfirm picom-jonaburg-git
}

function install_utils() {
    # Install sound server.
    sudo pacman -S --noconfirm pipewire-audio pipewire-alsa pipewire-pulese pipewire-jack alsa-utils

    # Install and setup backlight management.
    usermod -aG video joseph
    echo "ACTION==\"add\", SUBSYSTEM==\"backlight\", RUN+=\"/bin/chgrp video $sys$devpath/brightness\", RUN+=\"/bin/chmod g+w $sys$devpath/brightness" > /etc/udev/rules.d/backlight.rules
    sudo pacman -S light

    # Install bluetooth protocol stack.
    sudo pacman -S bluez bluez-utils

    # Install maim for screenshots.
    sudo pacman -S maim

    # Install libnotify and notification server.
    sudo pacman -S libnotify dunst
}

function setup_terminal() {
    # Install zsh and set it as the default shell.
    sudo pacman -S --noconfirm zsh
    chsh -s $(which zsh)

    # Install oh-my-zsh.
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    # Install Neovim and Kitty.
    sudo pacman -S --noconfirm neovim kitty
}

function install_apps() {
    # Install ranger (file manager).
    sudo pacman -S --noconfirm ranger

    # Install google-chrome.
    paru -S --noconfirm google-chrome
}

function install_optional_deps() {
    # Install powerline-fonts for the agnoster theme of zsh.
    sudo pacman -S --noconfirm powerline-fonts

    # Install zsh-syntax-highlighting and zsh-autosuggestions.
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

    # Install Packer for Neovim.
    paru -S --noconfirm nvim-packer-git

    # Install JetBrains Mono nerd font.
    sudo pacman -S --noconfirm ttf-jetbrains-mono-nerd

    # Install pillow for ranger image preview. 
    pip install pillow
}

function setup_dotfiles() {
    # Install and set up chezmoi and dotfiles.
    sudo pacman -S --noconfirm chezmoi
    chezmoi init --apply https://github.com/joseph-amirth/.dotfiles.git
}

wait_for_internet_connection

install_prerequisites

install_aur_helper

install_de

install_utils

setup_terminal

install_apps

install_optional_deps

setup_dotfiles
