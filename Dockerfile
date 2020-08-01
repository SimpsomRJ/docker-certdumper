FROM docker:latest

RUN apk -U --no-cache add inotify-tools util-linux bash openssl
RUN apk --no-cache upgrade

COPY run.sh /

RUN ["chmod", "+x", "/run.sh"]

COPY --from=ldez/traefik-certs-dumper:v2.7.0 /usr/bin/traefik-certs-dumper /usr/bin/traefik-certs-dumper

VOLUME ["/traefik"]
VOLUME ["/output"]

ENTRYPOINT ["/run.sh"]
