#!/bin/sh
#
#         ____  _____
# ___ ___|  _ \| ____|
#/ __/ __| | | |  _|
#\__ \__ \ |_| | |___
#|___/___/____/|_____|
#
# speedie's simple desktop environment
#
########################################
# No need to edit, script should work for you.
# Only Debian, Arch and Gentoo based distros are supported!

echo "         ____  _____ "
echo " ___ ___|  _ \| ____|"
echo "/ __/ __| | | |  _|  "
echo "\__ \__ \ |_| | |___ "
echo "|___/___/____/|_____|"
echo "speedie's simple desktop environment install script"
echo "We're checking your system" 

# Find out what package manager the user is using
if [ -f "/usr/bin/apt" ]; then
    pkg=apt && echo "Detected package manager as: $pkg"
elif [ -f "/usr/bin/pacman" ]; then
    pkg=pacman && echo "Detected package manager as: $pkg"
elif [ -f "/usr/bin/emerge" ]; then
    pkg=portage && echo "Detected package manager as: $pkg"
elif [ -f "/etc/doas.conf" ]; then
	perm=doas
elif [ -f "/etc/sudoers" ]; then
	perm=sudo
fi

# Check if we're running as root
if [ $(whoami) = 'root' ]; then
	echo "You are a root user, won't use $perm" && perm=echo "!!Root!!" &&
fi

#perm=doas # Uncomment to override.
#pkg=emerge # Uncomment to override.

echo "Installing dependencies"

# libxft

if [ $(echo $pkg) = 'apt' ]; then
	$perm apt install libxinerama libxft-dev git xorg xinit fonts-font-awesome fonts-terminus feh pipewire pulsemixer && echo "(Debian) installed packages"
elif [ $(echo $pkg) = 'pacman' ]; then
	$perm pacman -Sy base-devel libxinerama libxft git xorg-server xorg-xinit ttf-font-awesome terminus-font picom feh pipewire pulsemixer&& echo "(Arch Linux) Installed packages"
elif [ $(echo $pkg) = 'portage' ]; then
	$perm emerge --quiet x11-libs/libXinerama xorg-server xorg-xinit media-fonts/fontawesome media-fonts/terminus-font x11-libs/libXft picom feh pipewire pulsemixer && echo "(Gentoo) Emerged packages"
fi

echo "Installed required dependencies"

cd ~/ && mkdir .ssDE && cd .ssDE

echo "Downloading components"
wget https://github.com/speediegamer/configurations/archive/ref/heads/main.zip && echo "Downloaded"
unzip main.zip && echo "unzip" && cd .. && mkdir .config

echo "Copying source code"
cp -r ~/.ssDE/configurations-main/dwm ~/.config && echo "Copied dwm source code"
cp -r ~/.ssDE/configurations-main/slstatus ~/.config && echo "Copied slstatus source code"
cp -r ~/.ssDE/configurations-main/dmenu ~/.config && echo "Copied dmenu source code"
cp -r ~/.ssDE/configurations-main/st ~/.config && echo "Copied st source code"
cp -r ~/.ssDE/configurations-main/picom ~/.config && echo "Copied picom configuration"

cd ~/.config/dwm && make && echo "Compiled dwm"
cd ~/.config/slstatus && make && echo "Compiled slstatus"
cd ~/.config/dmenu && make && echo "Compiled dmenu"
cd ~/.config/st && make && echo "Compiled st"

echo "# This file was created by ssDE, feel free to edit as you wish!" >> ~/.xinitrc && echo "Added simple note"
echo "startx" >> ~/.bash_profile && echo "Added startx to ~/.bash_profile"
echo "pipewire &" >> ~/.xinitrc && echo "Added pipewire & to ~/.xinitrc"
echo "~/.config/slstatus/slstatus &" >> ~/.xinitrc && echo "Added slstatus & to ~/.xinitrc"
echo "feh --bg-scale ~/.config/.wallpaper.png" >> ~/.xinitrc && echo "Added wallpaper to ~/.xinitrc"
echo "picom &" >> ~/.xinitrc && echo "Added picom & to ~/.xinitrc"
echo "~/.config/dwm/dwm" >> ~/.xinitrc && echo "Added dwm to ~/.xinitrc"

sleep 3 && clear

echo " _____ _                 _                        _  "
echo "|_   _| |__   __ _ _ __ | | __  _   _  ___  _   _| | "
echo "  | | | '_ \ / _` | '_ \| |/ / | | | |/ _ \| | | | | "
echo "  | | | | | | (_| | | | |   <  | |_| | (_) | |_| |_| "
echo "  |_| |_| |_|\__,_|_| |_|_|\_\  \__, |\___/ \__,_(_) "
echo "                                |___/                "

echo "ssDE has been installed."
echo "Have a good day!"

sleep 3

exit
