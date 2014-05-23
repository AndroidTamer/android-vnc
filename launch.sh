#!/bin/bash
Xvfb :0 -extension GLX -screen 0 480x800x24&
DISPLAY=:0 emulator -avd test -snapshot -no-boot-anim&
x11vnc -usepw -display :0
exit 0
