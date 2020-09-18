#!/bin/sh
OUTDIR=/run/user/`id -u $USER`/rec
mkdir -p $OUTDIR/done

cd $OUTDIR
watch -n 10 "df -h .; tree --du -h"

exit 0
