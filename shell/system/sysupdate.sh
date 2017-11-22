#!/bin/bash
# Install online-updates on debian-based systems.
# Run from cron with:
# 30 5 * * * /root/bin/sysupdate.sh >/var/log/sysupdate.log 2>&1

# Bei Aufruf über cron ist offenbar kein Suchpfad gesetzt. Daher hier nachholen:
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH

# Fehlermeldungen vermeiden:
export TERM=xterm-256color

# siehe:
# http://www.microhowto.info/howto/perform_an_unattended_installation_of_a_debian_package.html
# http://serverfault.com/questions/227190/how-do-i-ask-apt-get-to-skip-any-interactive-post-install-configuration-steps
export DEBIAN_FRONTEND=noninteractive

apt-get --assume-yes update
apt-get --assume-yes upgrade
