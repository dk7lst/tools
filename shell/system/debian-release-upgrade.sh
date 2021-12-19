#!/bin/sh
lsb_release -a
uname -mrs
cat /etc/os-release
cat /etc/debian_version

sed -i 's/buster\/updates/bullseye-security/g' /etc/apt/sources.list
sed -i 's/buster/bullseye/g' /etc/apt/sources.list

#apt update
#apt upgrade
#apt full-upgrade
#apt autoremove
