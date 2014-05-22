#!/bin/bash
Xvfb :0& DISPLAY=:0 emulator -avd test &
x11vnc -usepw -display :0
exit 0
