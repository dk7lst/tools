#!/bin/sh
# Script to free some disk space on Debian systems.

# Show and purge apt cache:
du -sh /var/cache/apt/archives/
apt-get clean

# Show and purge logs:
journalctl --disk-usage
journalctl --vacuum-size=200M
