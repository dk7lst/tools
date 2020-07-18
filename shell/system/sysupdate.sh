#!/bin/bash
# Install online-updates on debian-based systems.
# Run from cron with:
# 30 5 * * * /root/bin/sysupdate.sh >/var/log/sysupdate.log 2>&1

# siehe:
# http://www.microhowto.info/howto/perform_an_unattended_installation_of_a_debian_package.html
# http://serverfault.com/questions/227190/how-do-i-ask-apt-get-to-skip-any-interactive-post-install-configuration-steps
# https://debian-handbook.info/browse/de-DE/stable/sect.automatic-upgrades.html

# Bei Aufruf über cron ist offenbar kein Suchpfad gesetzt. Daher hier nachholen:
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH

# Fehlermeldungen und Dialoge vermeiden:
export TERM=xterm-256color
export DEBIAN_FRONTEND=noninteractive
export NEEDRESTART_MODE=l

date
apt-get --assume-yes update
apt-get --assume-yes -o DPkg::options::="--force-confdef" -o DPkg::options::="--force-confold" upgrade
date
