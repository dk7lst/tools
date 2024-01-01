#!/bin/sh
lsb_release -a
uname -mrs
cat /etc/os-release
cat /etc/debian_version

sed -i 's/bullseye/bookworm/g' /etc/apt/sources.list

# TODO: Edit files in "/etc/apt/sources.list.d" as needed!

#apt update
#apt upgrade --without-new-pkgs
#apt full-upgrade
#apt autoremove
