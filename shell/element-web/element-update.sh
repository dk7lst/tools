#!/bin/bash
# Script to check for new version of Element from github
# and download+install new version, if update is avaiable
# Inspired by https://gist.github.com/MurzNN/ee64f98ab2e71b886c41d55594e5dd9e

# URLs:
# - https://github.com/element-hq/element-web
# - https://github.com/element-hq/element-web/releases
# - https://github.com/element-hq/element-web/releases/latest

# Change to a safe location and don't clutter CWD in case anything goes wrong:
cd /tmp

# Directory where Element files must be placed, without trailing "/".
DIRECTORY_INSTALL=/mywebserverpath/htdocs/element

# Config file to use:
CONFIGFILE=/etc/element-config.json

# Directory for temp files - must be different than install directory!
DIRECTORY_TMP=/tmp

VERSION_URL=https://api.github.com/repos/element-hq/element-web/releases/latest

command -v curl >/dev/null 2>&1 || { echo "You need to install "curl" package for this script: sudo apt install curl"; exit 1; }
command -v tar >/dev/null 2>&1 || { echo "You need to install "tar" package for this script: sudo apt install tar"; exit 1; }
command -v jq >/dev/null 2>&1 || { echo "You need to install "jq" package for this script: sudo apt install jq"; exit 1; }

VERSION_LATEST=`curl -s $VERSION_URL | jq -r '.name' | sed s/v//` || { echo "Error checking last Element version!"; exit 1; }

if ( [[ -z "$VERSION_LATEST" ]] || [ "$VERSION_LATEST" == "null" ] ); then
  echo "Error! Received bad version number from $VERSION_URL: $VERSION_LATEST"
  exit 1
fi

VERSION_INSTALLED=`cat $DIRECTORY_INSTALL/version`

# Test-Mode:
#VERSION_INSTALLED="TESTMODE"

if ( [ "$VERSION_INSTALLED" != "$VERSION_LATEST" ] ); then
  echo "Element: Installed version is $VERSION_INSTALLED, version found in GitHub releases: $VERSION_LATEST"

  rm -f $DIRECTORY_TMP/element-latest.tar.gz $DIRECTORY_TMP/element-latest.tar.gz.asc

  DL_URL=`curl -s $VERSION_URL | jq -r '.assets[0].browser_download_url'`
  echo "Downloading: $DL_URL"
  curl -L -o $DIRECTORY_TMP/element-latest.tar.gz $DL_URL || { echo "Error downloading element-latest.tar.gz"; exit 1; }
  curl -L -o $DIRECTORY_TMP/element-latest.tar.gz.asc $DL_URL.asc || { echo "Error downloading element-latest.tar.gz.asc"; exit 1; }

  if ! gpg --batch --verify $DIRECTORY_TMP/element-latest.tar.gz.asc $DIRECTORY_TMP/element-latest.tar.gz ; then
    echo "SIGNATURE ERROR!"
    rm -f $DIRECTORY_TMP/element-latest.tar.gz $DIRECTORY_TMP/element-latest.tar.gz.asc
    exit 1
  fi

  echo "SIGNATURE OK!"
  echo

  # Backup old version:
  rm -Rf $DIRECTORY_INSTALL.old
  mv $DIRECTORY_INSTALL $DIRECTORY_INSTALL.old
  chmod 700 $DIRECTORY_INSTALL.old

  # Install new version:
  mkdir -p $DIRECTORY_INSTALL
  cd $DIRECTORY_INSTALL
  mv $DIRECTORY_TMP/element-latest.tar.gz .
  mv $DIRECTORY_TMP/element-latest.tar.gz.asc .

  tar xzf element-latest.tar.gz --strip-components=1
  chown -R root:root .
  ln -s $CONFIGFILE config.json

  echo "Config diff:"
  diff config.sample.json config.json
  
  echo "Element succesfully updated from $VERSION_INSTALLED to $VERSION_LATEST";
#else
#  echo "Installed Element version $VERSION_INSTALLED, last is $VERSION_LATEST - no update found, exiting.";
fi

exit 0
