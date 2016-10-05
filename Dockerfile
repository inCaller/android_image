FROM ubuntu:14.04

ADD version version

RUN \
apt-get update  && \
apt-get install -y software-properties-common debconf-utils  && \
add-apt-repository -y ppa:webupd8team/java  && \
apt-get update  && \
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections  && \
apt-get install -y oracle-java8-installer oracle-java8-set-default  && \
pushd /opt  && \
wget http://dl.google.com/android/android-sdk_r$(cat version)-linux.tgz  && \
tar -xvf android-sdk*-linux.tgz  && \
echo 'export ANDROID_HOME=/opt/android-sdk-linux' >> /etc/profile.d/android.sh  && \
echo 'export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools' >> /etc/profile.d/android.sh  && \
source /etc/profile.d/android.sh  && \
apt-get install -y lib32z1 lib32ncurses5 lib32bz2-1.0 lib32stdc++6  && \
apt-get install -y git expect && \
rm -v android-sdk*-linux.tgz && rm -rf /var/lib/apt/lists/* 