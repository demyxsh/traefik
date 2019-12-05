FROM traefik

LABEL sh.demyx.image demyx/traefik
LABEL sh.demyx.maintainer Demyx <info@demyx.sh>
LABEL sh.demyx.url https://demyx.sh
LABEL sh.demyx.github https://github.com/demyxco
LABEL sh.demyx.registry https://hub.docker.com/u/demyx

# Set default environment variables
ENV TZ=America/Los_Angeles
ENV TRAEFIK_ENTRYPOINTS_HTTP_ADDRESS=:8081
ENV TRAEFIK_ENTRYPOINTS_HTTPS_ADDRESS=:8082

# Create demyx user and configure
RUN set -ex; \
    addgroup -g 1000 -S demyx; \
    adduser -u 1000 -D -S -G demyx demyx; \
    apk add --no-cache --update tzdata; \
    install -d -m 0755 -o demyx -g demyx /demyx

# Lockdown
RUN set -ex; \
	rm -f /bin/sh; \
	rm -f /bin/ash; \
	rm -f /usr/bin/wget

EXPOSE 8081 8082

USER demyx

ENTRYPOINT ["traefik"]
