FROM ksoichiro/android

MAINTAINER Subho "subho.halder@gmail.com"

RUN     apt-get update -y
RUN     apt-get install -y x11vnc xvfb libncurses5:i386 libstdc++6:i386

RUN rm -rf /opt/android-sdk-linux/temp
RUN rm -rf /opt/android-sdk-linux/platform-tools

RUN ( sleep 5 && while [ 1 ]; do sleep 1; echo y; done ) | android update sdk --filter platform-tools,build-tools-19.0.3,sysimg-17,android-17,addon-google_apis-google-17,extra-google-admob_ads_sdk,extra-google-analytics_sdk_v2,extra-google-google_play_services,extra-google-play_apk_expansion,extra-google-play_billing,extra-google-play_licensing --no-ui --force

# Set up and run emulator
RUN echo no | android create avd -t "Google Inc.:Google APIs:17" -c 512M -s 480x800 -n test
# Avoid emulator assumes HOME as '/'.
ENV HOME /root

# Install vnc, xvfb in order to create a 'fake' display and firefox
RUN     mkdir ~/.vnc
# Setup a password
RUN     x11vnc -storepasswd 1234 ~/.vnc/passwd
EXPOSE 5900
#Do a launch script

ADD launch.sh /usr/local/bin/launch
RUN chmod 755 /usr/local/bin/launch
