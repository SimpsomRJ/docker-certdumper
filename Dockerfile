FROM docker:28.5.0

RUN \
    apk update && \
    apk add -U --no-cache \
        inotify-tools \
        util-linux \
        bash \
        openssl && \
    apk --no-cache upgrade

COPY bin/dump.sh /usr/bin/dump
COPY bin/healthcheck.sh /usr/bin/healthcheck

RUN ["chmod", "+x", "/usr/bin/dump", "/usr/bin/healthcheck"]

HEALTHCHECK --interval=30s --timeout=10s --retries=5 \
  CMD ["/usr/bin/healthcheck"]

COPY --from=ldez/traefik-certs-dumper:v2.10.0 /usr/bin/traefik-certs-dumper /usr/bin/traefik-certs-dumper

VOLUME ["/traefik"]
VOLUME ["/output"]

ENTRYPOINT ["/usr/bin/dump"]
