
FROM docker:20.10.7
LABEL MAINTAINER Forest Keepers <Jeroen.knoops@philips.com>

USER root

ENV GOSS_VER=v0.3.7 \
    GOSS_FILES_STRATEGY=cp \
    GOSS_FILES_PATH=/app

RUN apk update \
 && apk --no-cache add \
      bash \
      curl \
      git \
 && rm -rf /var/cache/apk/*

RUN curl -L https://github.com/aelsabbahy/goss/releases/download/${GOSS_VER}/goss-linux-amd64 -o /usr/local/bin/goss && \
    chmod +rx /usr/local/bin/goss && \
    curl -L https://raw.githubusercontent.com/aelsabbahy/goss/${GOSS_VER}/extras/dgoss/dgoss -o /usr/local/bin/dgoss && \
    chmod +rx /usr/local/bin/dgoss;

COPY /0/alpine/test.sh /test.sh
RUN chmod +x /test.sh

ADD REPO .
ADD TAGS .

CMD ["/test.sh"]
