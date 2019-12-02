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

# Create demyx user and install tzdata
RUN set -ex; \
    addgroup -g 1000 -S demyx; \
    adduser -u 1000 -D -S -G demyx demyx; \
    apk add --no-cache --update tzdata

# Remove all binaries
RUN set -ex; \
	mv /usr/local/bin/traefik /; \
	rm -rf /usr/local/bin; \
	rm -rf /usr/local/sbin; \
	rm -rf /usr/sbin; \
	rm -rf /usr/bin; \
	rm -rf /sbin; \
	rm -rf /bin

# Set PATH to null
ENV PATH=

EXPOSE 8081 8082

USER demyx

ENTRYPOINT ["/traefik"]
