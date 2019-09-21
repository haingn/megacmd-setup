#!/usr/bin/env bash

if (( $EUID != 0 )); then
    echo "Please run as root"
    exit 1
fi

if [ -z "$1" ]; then
    echo "./install.sh <your_authtoken>"
    exit 1
fi

mkdir -p /opt/ngrok

cd ngrok-setup
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip
unzip ngrok-stable-linux-arm.zip

cp ngrok /opt/ngrok/
chmod +x /opt/ngrok/ngrok
cp uninstall.sh /opt/ngrok/
cp ngrok.service /lib/systemd/system/
cp ngrok.yml /opt/ngrok/
sed -i "s/<add_your_token_here>/$1/g" /opt/ngrok/ngrok.yml

systemctl enable ngrok.service
systemctl start ngrok.service
systemctl status ngrok.service

cd ~/
