#!/bin/sh

# https://www.debian.org/releases/trixie/release-notes/upgrading.en.html
# https://www.debian.org/releases/trixie/release-notes/issues.en.html

lsb_release -a
uname -mrs
cat /etc/os-release
cat /etc/debian_version

sed -i 's/bookworm/trixie/g' /etc/apt/sources.list

# TODO: Edit files in "/etc/apt/sources.list.d" as needed!

#apt update
#apt upgrade --without-new-pkgs
#apt full-upgrade
#apt autoremove
