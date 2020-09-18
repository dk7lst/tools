#!/bin/sh

#echo $1

DIR=`dirname $1`
FILE=`basename $1 .wav`

NORMFILE=$DIR/${FILE}_n.wav

# Lautstärke angleichen:
#sox $1 $NORMFILE norm -0.1
sox $1 $NORMFILE compand 0.3,1 6:-70,-60,-20 -20 -90 0.2 norm -0.1 >/dev/null 2>&1

# Beide Versionen nach MP3 encoden und Wave bei Erfolg löschen:
lame -b 24 --quiet $1 $DIR/${FILE}_o.mp3 && rm -f $1
lame -b 24 --quiet $NORMFILE && rm -f $NORMFILE
