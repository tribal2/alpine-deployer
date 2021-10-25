FROM alpine:3.14.2

ARG BUILD_DATE
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date="$BUILD_DATE" \
      org.label-schema.name="alpine-deployer" \
      org.label-schema.description="Alpine image with SSH client and RSync installed" \
      org.label-schema.vcs-url="https://github.com/tribal2/alpine-deployer" \
      maintainer="Ricardo Tribaldos <rtribaldos@barustudio.com>"

RUN apk add --update --no-cache openssh rsync

WORKDIR /setup

COPY . .

RUN chmod 500 ssh*.sh
