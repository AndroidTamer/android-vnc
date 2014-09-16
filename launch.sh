#!/bin/bash
Xvfb :0 -extension GLX -screen 0 480x800x24&
DISPLAY=:0 emulator-arm -avd test -noaudio&
known_window=$(xwininfo -name  "5554:test"|sed -e 's/^ *//'|grep -E "^0x"|awk '{ print $1 }')
x11vnc -usepw -id $known_window -display :0
exit 0
