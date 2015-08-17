# Claire Cordova + Golang Docker file
# Mashed up from kallikrein/cordova and official golang:1.4.2

FROM kallikrein/cordova:5.1.1

MAINTAINER Anes Hasicic <anes.hasicic@gmail.com> 

# CORDOVA 

RUN \
    apt-get update && \
    apt-get install -y lib32stdc++6 lib32z1 \
    gcc libc6-dev make --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# download and extract android sdk
RUN curl http://dl.google.com/android/android-sdk_r24.2-linux.tgz | tar xz -C /usr/local/
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# update and accept licences
RUN ( sleep 5 && while [ 1 ]; do sleep 1; echo y; done ) | /usr/local/android-sdk-linux/tools/android update sdk --no-ui -a --filter platform-tool,build-tools-22.0.1,android-22

ENV GRADLE_USER_HOME /src/gradle
VOLUME /src

# GOLANG

ENV GOLANG_VERSION 1.4.2

RUN curl -sSL https://golang.org/dl/go$GOLANG_VERSION.src.tar.gz \
        | tar -v -C /usr/src -xz

RUN cd /usr/src/go/src && ./make.bash --no-clean 2>&1

ENV PATH /usr/src/go/bin:$PATH

RUN mkdir -p /go/src /go/bin && chmod -R 777 /go
ENV GOPATH /go
ENV PATH /go/bin:$PATH

RUN go get -u github.com/gopherjs/gopherjs

ADD ./apk-build /usr/local/bin/

WORKDIR /src
