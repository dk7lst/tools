#!/bin/bash
vncserver -kill :1 >/dev/null 2>&1
rm /tmp/.X11-unix/X* >/dev/null 2>&1
vncserver :1 -geometry 1440x900 -alwaysshared >/dev/null 2>&1
