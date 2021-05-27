FROM debian:buster

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
      apt-transport-https \
      binutils \
      ca-certificates \
      dirmngr \
      gnupg \
      software-properties-common \
      wget

RUN wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - && \
    echo "deb https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ buster main Release" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y adoptopenjdk-8-hotspot maven

RUN mkdir /root/.gradle && echo 'org.gradle.jvmargs=-Xmx2024m -XX:MaxPermSize=512m' > /root/.gradle/gradle.properties

RUN mkdir -p /src/build

WORKDIR /src/build

ENV ANDROID_HOME=/usr/local/lib/android

ENTRYPOINT ["./gradlew", "--no-daemon"]
CMD ["assembleConversationsFreeCompatRelease"]
