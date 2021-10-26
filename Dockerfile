ARG ALPINE_VERSION=3.14.2
FROM alpine:${ALPINE_VERSION}

ARG VERSION
ARG BUILD_DATE
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date="$BUILD_DATE" \
      org.label-schema.version="$VERSION" \
      org.label-schema.name="alpine-deployer" \
      org.label-schema.description="Alpine image with SSH client and RSync installed" \
      org.label-schema.vcs-url="https://github.com/tribal2/alpine-deployer" \
      maintainer="Ricardo Tribaldos <rtribaldos@barustudio.com>"

RUN apk add --update --no-cache openssh rsync \
    && rm -rf /var/cache/apk/* \
    && mkdir -p /root/.ssh \
    && mkdir /setup

COPY ./ssh* /setup/
RUN chmod 500 /setup/*

COPY ./.profile /root/.profile
ENV ENV="/root/.profile"
