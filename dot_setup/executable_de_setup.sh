# Script to setup bspwm in Arch.

# Wait for internet connection to be established.
while ! ping -c1 8.8.8.8 &> /dev/null
do
    echo "Ping failed - trying again in 1 second(s).\nCheck internet connection."
    sleep 1
done

# Install X.
pacman -S --noconfirm xorg

# Install paru (AUR helper).
git clone https://aur.archlinux.org/paru.git /aurtemp
cd /aurtemp
makepkg --syncdeps
pacman -U --noconfirm *.pkg.tar.zst
cd / && rm -rf /aurtemp

# Install bspwm, sxhkd, rofi and picom.
pacman -S --noconfirm bspwm sxhkd rofi
paru -S --noconfirm picom-jonaburg-git

systemctl enable sddm.service
