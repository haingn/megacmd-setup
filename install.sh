#!/usr/bin/env bash

if (( $EUID != 0 )); then
    echo "Please run as root"
    exit 1
fi

if [ -z "$1" ]; then
    echo "./install.sh <your_authtoken>"
    exit 1
fi
apt-get update && apt-get upgrade -y
apt install libc-ares2 libcrypto++6 libpcrecpp0v5 libmediainfo0v5 libzen0v5
apt --fix-broken install -y
wget https://mega.nz/linux/MEGAsync/Raspbian_10.0/arm/megacmd-Raspbian_10.0_armhf.deb
dpkg -i megacmd-Raspbian_10.0_armhf.deb -y
touch /etc/profile.d/startup.sh && echo'mega-sync'>>/etc/profile.d/startup.sh
sed -i "s/<add_your_token_here>/$1/g" mega-login
cd ~/
