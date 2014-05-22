#!/bin/bash
Xvfb :0 -extension GLX -screen 0 1024x780x24& DISPLAY=:0 emulator -avd test &
x11vnc -usepw -display :0
exit 0
