#!/bin/sh
apt update
apt dist-upgrade
apt autoremove
echo

# Check that really nothing is left:
apt upgrade

echo
read -p "Reboot? [y/N] " rply
case $rply in
  [Yy]* ) reboot;;
esac
