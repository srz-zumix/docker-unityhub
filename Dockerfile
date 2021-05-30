FROM ubuntu:latest

LABEL maintainer "srz_zumix <https://github.com/srz-zumix>"

ENV DEBIAN_FRONTEND=noninteractive
RUN  apt-get update \
  && apt-get install -q -y --no-install-recommends \
    ca-certificates \
    libasound2 \
    libc6-dev \
    libcap2 \
    libgconf-2-4 \
    libglu1 \
    libgtk-3-0 \
    libncurses5 \
    libnotify4 \
    libnss3 \
    libxtst6 \
    libxss1 \
    wget \
    xvfb \
    zenity \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /root/.config/Unity Hub
WORKDIR /opt/unity
RUN wget --no-verbose -O /tmp/UnityHub.AppImage "https://public-cdn.cloud.unity3d.com/hub/prod/UnityHub.AppImage" \
 && chmod +x /tmp/UnityHub.AppImage \
 && /tmp/UnityHub.AppImage --appimage-extract \
 && mv ./squashfs-root ./UnityHub

COPY UnityHub /usr/bin/
COPY UnityHubCLI /usr/bin/
RUN chmod +x /usr/bin/UnityHub /usr/bin/UnityHubCLI \
    && touch "/root/.config/Unity Hub/eulaAccepted" \
    && rm -f /tmp/UnityHub.AppImage

ENTRYPOINT [ "UnityHubCLI" ]
