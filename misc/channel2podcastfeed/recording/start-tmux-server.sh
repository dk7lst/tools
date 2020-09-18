#!/bin/sh
cd /home/CHANGEME
tmux new-session -ds main -n Shell /bin/bash
tmux new-window -n Mixer alsamixer -c 1 -V capture
tmux new-window -n Status "echo Waiting...; sleep 22; ./showstatus.sh"
tmux new-window -n Rec "echo Waiting...; sleep 20; ./soxrec.sh"

exit 0
