FROM hypriot/rpi-alpine-scratch

RUN apk add --update \
    git \
    python \
    unrar \
    zip \
    supervisor \
    && git clone --depth 1 -b master --single-branch https://github.com/rembo10/headphones.git /app \
    && mkdir /config /blackhole /sorted /unsorted \
    && rm -rf /var/cache/apk/*

VOLUME /config /blackhole /sorted /unsorted

EXPOSE 8181

CMD [ "--datadir=/config", "--nolaunch" ]
ENTRYPOINT ["/usr/bin/env","python2","/app/Headphones.py"]
