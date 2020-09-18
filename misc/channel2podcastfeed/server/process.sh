#!/bin/sh
# Aufruf aus crontab von "www-data"-User:
# crontab -eu www-data
# */5 * * * * voller/pfad/process.sh

# Recorder etwas Zeit zum Hochladen der Daten geben, dann klappt es
# vielleicht noch in dieser Runde:
sleep 2m

# Alles relativ zum Skriptverzeichnis:
cd `dirname $0`

SRCDIR="inbox/"
DSTDIR="mp3/"

LOCKFILE="${SRCDIR}process.lock"
if [ -f $LOCKFILE ]; then
  echo "ERROR: $0 locked! ($LOCKFILE)"
  exit 1
fi
touch $LOCKFILE

# Alte Dateien aufräumen:
find $DSTDIR -name "rec-*.mp3" -mmin +10080 -exec rm {} \;

# Noch Dateien zum Konvertieren nach MP3 vorhanden?
if ls ${SRCDIR}rec-*.wav 1>/dev/null 2>&1; then
  # Alle Wave-Dateien verarbeiten:
  nice -n 15 find ${SRCDIR}rec-*[0-9].wav -type f -exec ./processfile.sh {} \;
fi

# Noch MP3-Dateien zum Verschieben vorhanden?
if ls ${SRCDIR}rec-*.mp3 1>/dev/null 2>&1; then
  mv ${SRCDIR}rec-*.mp3 $DSTDIR
fi

rm $LOCKFILE
exit 0
