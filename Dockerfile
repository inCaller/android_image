FROM ubuntu:14.04

ADD version /opt/version

ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools
ENV TERM xterm-256color

RUN \
apt-get update  && \
apt-get install -y software-properties-common debconf-utils  && \
add-apt-repository -y ppa:webupd8team/java  && \
apt-get update  && \
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections  && \
apt-get install -y oracle-java8-installer oracle-java8-set-default  && \
cd /opt  && \
wget http://dl.google.com/android/android-sdk_r$(cat /opt/version)-linux.tgz  && \
tar -xvf android-sdk*-linux.tgz  && \
apt-get install -y lib32z1 lib32ncurses5 lib32bz2-1.0 lib32stdc++6  && \
apt-get install -y git expect && \
apt-get install -y libgl1-mesa-dev && \
rm -v android-sdk*-linux.tgz && rm -rf /var/lib/apt/lists/* && \
echo y|android update sdk --no-ui --all --filter platform-tools,extra-android-support,tools,build-tools-25.0.2,android-24,android-19,extra,sys-img-armeabi-v7a-android-19
