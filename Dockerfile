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
ENV GOLANG_VERSION 1.5
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOLANG_DOWNLOAD_SHA1 5817fa4b2252afdb02e11e8b9dc1d9173ef3bd5a

RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
    && echo "$GOLANG_DOWNLOAD_SHA1  golang.tar.gz" | sha1sum -c - \
    && tar -C /usr/local -xzf golang.tar.gz \
    && rm golang.tar.gz

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN go get -u github.com/gopherjs/gopherjs

ADD ./apk-build /usr/local/bin/

WORKDIR /src
