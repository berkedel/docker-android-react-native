# Base image
FROM ubuntu:18.04

# Author
LABEL maintainer "akhmad.hadi@gmail.com"

# support multiarch: i386 architecture
# install Java
# install essential tools
# install NodeJS 10.x
# install react-native-cli
RUN dpkg --add-architecture i386 && \
  apt-get update -y && \
  apt-get install -y --no-install-recommends libncurses5:i386 libc6:i386 libstdc++6:i386 lib32gcc1 lib32ncurses5 lib32z1 zlib1g:i386 && \
  apt-get install -y --no-install-recommends openjdk-8-jdk && \
  apt-get install -y --no-install-recommends git wget unzip && \
  wget -O - https://deb.nodesource.com/setup_10.x | bash && \
  echo fs.inotify.max_user_instances=524288 | tee -a /etc/sysctl.conf && sysctl -p && \
  echo fs.inotify.max_user_watches=524288 | tee -a /etc/sysctl.conf && sysctl -p && \
  echo fs.inotify.max_queued_events=524288 | tee -a /etc/sysctl.conf && sysctl -p && \
  apt-get install -y nodejs && \
  npm install -g react-native-cli

# set the environment variables
ENV ANDROID_HOME /opt/android-sdk
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools/bin
ENV _JAVA_OPTIONS -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap

# install Android SDK
# https://developer.android.com/studio/#downloads
ARG ANDROID_SDK_VERSION=4333796
ARG ANDROID_BUILD_VERSION=28
ARG ANDROID_TOOLS_VERSION=28.0.3
RUN mkdir -p ${ANDROID_HOME} && cd ${ANDROID_HOME} && \
  wget -q https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip && \
  unzip *tools*linux*.zip && \
  rm *tools*linux*.zip && \
  yes | sdkmanager --licenses && \
  yes | sdkmanager "platform-tools" "platforms;android-$ANDROID_BUILD_VERSION" "build-tools;$ANDROID_TOOLS_VERSION"
