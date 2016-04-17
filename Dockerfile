FROM hypriot/rpi-alpine-scratch

# Install packages
RUN apk add --update \
    git \
    python \
    unrar \
    zip \
    supervisor
RUN rm -rf /var/cache/apk/*

# Create user
RUN id headphones || adduser -S -s /bin/false -H -D headphones
RUN addgroup headphones users

# Create directories
RUN mkdir -p /config /blackhole /sorted /unsorted /app && \
    chmod 775 /config /blackhole /sorted /unsorted && \
    chgrp -R users /sorted /unsorted /blackhole && \
    chown -R headphones:users /config /app

# Continue as user 'headphones'
USER headphones

RUN git clone --depth 1 -b master --single-branch https://github.com/rembo10/headphones.git /app 

VOLUME /config /blackhole /sorted /unsorted

EXPOSE 8181

CMD [ "--datadir=/config", "--nolaunch" ]
ENTRYPOINT ["/usr/bin/env","python2","/app/Headphones.py"]
