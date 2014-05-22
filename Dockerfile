FROM ksoichiro/android

MAINTAINER Subho "subho.halder@gmail.com"

RUN echo y | android update sdk --filter platform-tools,build-tools-19.0.3,sysimg-17,android-17,addon-google_apis-google-17,extra-android-support,extra-google-admob_ads_sdk,extra-google-analytics_sdk_v2,extra-google-google_play_services,extra-google-play_apk_expansion,extra-google-play_billing,extra-google-play_licensing,extra-android-support --no-ui --force

# Set up and run emulator
RUN echo no | android create avd --force -n test -t "Google Inc.:Google APIs:17" -c 100M -s 480x800
# Avoid emulator assumes HOME as '/'.
ENV HOME /root
ADD wait-for-emulator /usr/local/bin/
ADD start-emulator /usr/local/bin/

RUN mkdir -p /opt/tmp && android create project -g -v 0.9.+ -a MainActivity -k com.example.example -t android-17 -p /opt/tmp
#RUN cd /opt/tmp && ./gradlew tasks
RUN rm -rf /opt/tmp

RUN     apt-get update -y

# Install vnc, xvfb in order to create a 'fake' display and firefox
RUN     apt-get install -y x11vnc xvfb
RUN     mkdir ~/.vnc
# Setup a password
RUN     x11vnc -storepasswd 1234 ~/.vnc/passwd
EXPOSE 5900
#Do a launch script

ADD launch.sh /root/launch.sh
RUN chmod 755 /root/launch.sh
