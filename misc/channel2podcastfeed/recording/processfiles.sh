#!/bin/sh
#echo processfiles.sh: dir: $1 file: $2

# Nicht beim Starten der neuen Aufnahme stören:
sleep 5

# Leere Segmente löschen:
find $1/rec-*.wav -type f -size -32k -exec rm -f {} \;

# Noch Dateien zum Konvertieren nach MP3 vorhanden?
if ls $1/rec-*.wav 1>/dev/null 2>&1; then
  # Waves nach MP3 konvertieren (2. exec wird nur
  # ausgeführt wenn 1. erfolgreich war):
  nice -n 15 find $1/rec-*.wav -type f -exec lame --quiet {} \; -exec rm -f {} \;
fi

# Noch Dateien zum Hochladen vorhanden?
if ls $1/rec-*.mp3 1>/dev/null 2>&1; then
  # Hochladen & bei Erfolg löschen:
  find $1/rec-*.mp3 -type f -exec curl -F "file=@{}" https://CHANGEME/podcast/upload.php?token=CHANGEME \; -exec rm -f {} \;
fi

exit 0
