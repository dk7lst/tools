#!/bin/sh
# http://sox.sourceforge.net/sox.html
# https://digitalcardboard.com/blog/2009/08/25/the-sox-of-silence/comment-page-2/

# Verzeichnis auf RAM-Disk:
OUTDIR=/run/user/`id -u $USER`/rec
mkdir -p $OUTDIR/done

# Clean-up:
rm -f $OUTDIR/rec-*.wav

# Länge pro Datei in Sekunden:
CHUNKLEN=300

export AUDIODRIVER=alsa
#export AUDIODEV=plughw:1
#export AUDIODEV=vac0a

#sox -G -r 16k -c 1 -d $OUTDIR/rec.wav trim 0 300 silence -l 1 0.1 1% -1 2.0 1% : newfile : restart

while true; do
  FILE=rec-`date +%Y%m%d-%H%M`.wav
  sox -G -r 16k -c 1 -d $OUTDIR/$FILE trim 0 $CHUNKLEN silence -l 1 0.1 1% -1 2.0 1%
  mv $OUTDIR/$FILE $OUTDIR/done/$FILE
  ./processfiles.sh $OUTDIR/done $FILE &
done
