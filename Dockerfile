FROM golang:alpine as demyx_go

# Imports
COPY config /build

RUN set -ex; \
    cd /build; \
    go mod init github.com/demyxsh/traefik; \
    go mod tidy; \
    go build

FROM traefik

LABEL sh.demyx.image        demyx/traefik
LABEL sh.demyx.maintainer   Demyx <info@demyx.sh>
LABEL sh.demyx.url          https://demyx.sh
LABEL sh.demyx.github       https://github.com/demyxsh
LABEL sh.demyx.registry     https://hub.docker.com/u/demyx

# Set default environment variables
ENV DEMYX                   /demyx
ENV DEMYX_CONFIG            /etc/demyx
ENV DEMYX_LOG               /var/log/demyx
ENV DEMYX_ENDPOINT          tcp://demyx_socket:2375
ENV TZ                      America/Los_Angeles

# Packages
RUN set -ex; \
    apk add --no-cache --update bash tzdata

# Configure Demyx
RUN set -ex; \
    # Create demyx user
    addgroup -g 1000 -S demyx; \
    adduser -u 1000 -D -S -G demyx demyx; \
    \
    # Create demyx directories
    install -d -m 0755 -o demyx -g demyx "$DEMYX"; \
    install -d -m 0755 -o demyx -g demyx "$DEMYX_CONFIG"; \
    install -d -m 0755 -o demyx -g demyx "$DEMYX_LOG"; \
    \
    # Update .bashrc
    echo 'PS1="$(whoami)@\h:\w \$ "' > /home/demyx/.bashrc; \
    echo 'PS1="$(whoami)@\h:\w \$ "' > /root/.bashrc

# Imports
COPY --from=demyx_go /build/traefik /usr/local/bin/demyx-entrypoint    

# Finalize
RUN set -ex; \
    # Keep a local copy of Cloudflare's IPs
    DEMYX_IPV4="$(wget -qO- https://www.cloudflare.com/ips-v4 | sed 's/^/      - /')"; \
    DEMYX_IPV6="$(wget -qO- https://www.cloudflare.com/ips-v6 | sed 's/^/      - /')"; \
    echo "$DEMYX_IPV4" > "$DEMYX_CONFIG"/cf_ips; \
    echo "$DEMYX_IPV6" >> "$DEMYX_CONFIG"/cf_ips; \
    \
    # Lockdown
    chmod o-x /bin/busybox

EXPOSE 8080 8081 8082

USER demyx

ENTRYPOINT ["demyx-entrypoint"]
