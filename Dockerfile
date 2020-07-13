FROM golang:alpine as demyx_go

COPY src /build

RUN set -ex; \
    cd /build; \
    go mod init github.com/demyxco/traefik; \
    go build

FROM traefik

LABEL sh.demyx.image        demyx/traefik
LABEL sh.demyx.maintainer   Demyx <info@demyx.sh>
LABEL sh.demyx.url          https://demyx.sh
LABEL sh.demyx.github       https://github.com/demyxco
LABEL sh.demyx.registry     https://hub.docker.com/u/demyx

# Set default environment variables
ENV DEMYX                   /demyx
ENV DEMYX_CONFIG            /etc/demyx
ENV DEMYX_LOG               /var/log/demyx
ENV DEMYX_ENDPOINT          tcp://demyx_socket:2375
ENV TZ                      America/Los_Angeles

# Configure Demyx
RUN set -ex; \
    addgroup -g 1000 -S demyx; \
    adduser -u 1000 -D -S -G demyx demyx; \
    \
    install -d -m 0755 -o demyx -g demyx "$DEMYX"; \
    install -d -m 0755 -o demyx -g demyx "$DEMYX_CONFIG"; \
    install -d -m 0755 -o demyx -g demyx "$DEMYX_LOG"

# Packages
RUN set -ex; \
    apk add --no-cache --update tzdata

# Copy entrypoint
COPY --from=demyx_go /build/traefik /usr/local/bin/demyx-entrypoint

# Keep a local copy of Cloudflare's IPs
RUN set -ex; \
    DEMYX_IPV4="$(wget -qO- https://www.cloudflare.com/ips-v4 | tr '\n' ',')"; \
    DEMYX_IPV6="$(wget -qO- https://www.cloudflare.com/ips-v6 | tr '\n' ',' | sed 's/.$//')"; \
    echo "$(echo "$DEMYX_IPV4")$(echo "$DEMYX_IPV6")" > "$DEMYX_CONFIG"/cf_ips

# Finalize
RUN set -ex; \
    # Lockdown
    chmod o-x /bin/busybox

EXPOSE 8080 8081 8082

USER demyx

ENTRYPOINT ["demyx-entrypoint"]
