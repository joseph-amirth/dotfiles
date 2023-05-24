# Script to setup bspwm desktop environment in Arch.

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
}

function install_aur_helper() {
    # Install rust.
    sudo pacman -S --noconfirm rustup
    rustup default stable

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

    # Install sound server.
    sudo pacman -S --noconfirm pipewire-audio pipewire-alsa pipewire-pulese pipewire-jack alsa-utils
}

function install_utilities() {
    # Install and setup backlight manager.
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

wait_for_internet_connection
install_prerequisites
install_aur_helper
install_de
install_utilities
