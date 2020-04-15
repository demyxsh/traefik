FROM traefik

LABEL sh.demyx.image        demyx/traefik
LABEL sh.demyx.maintainer   Demyx <info@demyx.sh>
LABEL sh.demyx.url          https://demyx.sh
LABEL sh.demyx.github       https://github.com/demyxco
LABEL sh.demyx.registry     https://hub.docker.com/u/demyx

# Set default environment variables
ENV TRAEFIK_ROOT                        /demyx
ENV TRAEFIK_CONFIG                      /etc/demyx
ENV TRAEFIK_LOG                         /var/log/demyx
ENV TRAEFIK_ENTRYPOINTS_HTTP_ADDRESS    :8081
ENV TRAEFIK_ENTRYPOINTS_HTTPS_ADDRESS   :8082
ENV TZ                                  America/Los_Angeles

# Configure Demyx
RUN set -ex; \
    addgroup -g 1000 -S demyx; \
    adduser -u 1000 -D -S -G demyx demyx; \
    \
    install -d -m 0755 -o demyx -g demyx "$TRAEFIK_ROOT"; \
    install -d -m 0755 -o demyx -g demyx "$TRAEFIK_CONFIG"; \
    install -d -m 0755 -o demyx -g demyx "$TRAEFIK_LOG"

# Packages
RUN set -ex; \
    apk add --no-cache --update tzdata

# Finalize
RUN set -ex; \
    # Lockdown
	chmod o-x /bin/busybox; \

EXPOSE 8081 8082

USER demyx

ENTRYPOINT ["traefik"]
