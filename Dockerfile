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
ENV DEMYX_TRUSTED_IPS       173.245.48.0/20,103.21.244.0/22,103.22.200.0/22,103.31.4.0/22,141.101.64.0/18,108.162.192.0/18,190.93.240.0/20,188.114.96.0/20,197.234.240.0/22,198.41.128.0/17,162.158.0.0/15,104.16.0.0/12,172.64.0.0/13,131.0.72.0/22
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
    apk add --no-cache --update bash dumb-init tzdata

# Copy source
COPY src "$DEMYX_CONFIG"

# Finalize
RUN set -ex; \
    # demyx-config
    mv "$DEMYX_CONFIG"/config.sh /usr/local/bin/demyx-config; \
    chmod +x /usr/local/bin/demyx-config; \
    \
    # demyx-entrypoint
    mv "$DEMYX_CONFIG"/entrypoint.sh /usr/local/bin/demyx-entrypoint; \
    chmod +x /usr/local/bin/demyx-entrypoint; \
    \
    # Lockdown
    chmod o-x /bin/busybox

EXPOSE 8080 8081 8082

USER demyx

ENTRYPOINT ["demyx-entrypoint"]
