#!/bin/bash
Xvfb :0 -extension GLX -screen 0 480x800x24&
DISPLAY=:0 emulator-arm -avd test -noaudio -snapshot default-boot -snapstorage snapshots.img&
x11vnc -usepw -display :0
exit 0
