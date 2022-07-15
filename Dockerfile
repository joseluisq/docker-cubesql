FROM debian:11-slim

ARG CUBESQL_VERSION=latest
ARG CUBESQL_VERSION_REQUIRED=5.9.0

ENV CUBESQL_VERSION=${CUBESQL_VERSION}

LABEL version="${CUBESQL_VERSION_REQUIRED}" \
    description="Docker image for CubeSQL 5." \
    maintainer="Jose Quintana <joseluisq.net>"

RUN set -eux \
    && DEBIAN_FRONTEND=noninteractive apt-get update -qq \
    && DEBIAN_FRONTEND=noninteractive apt-get install -qq -y --no-install-recommends --no-install-suggests \
        ca-certificates \
        curl \
        less \
\
# Clean up local repository of retrieved packages and remove the package lists
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && true

RUN set -eux \
    && ver=$(echo $CUBESQL_VERSION | sed -e 's:\.::g') \
    && curl -Lo /tmp/cubesql.tar.gz https://sqlabs.com/download/cubesql/${ver}/cubesql_linux64bit.tar.gz \
    && mkdir -p /usr/local/bin \
    && tar xvfz /tmp/cubesql.tar.gz -C /usr/local/bin --strip-components=2 cubesql_64bit/data/cubesql \
    && chmod +x /usr/local/bin/cubesql \
    && echo "Verifing Cubesql server version..." \
    && ver_match=$(cubesql -y) \
    && if [ "${CUBESQL_VERSION_REQUIRED}" != "${ver_match}" ]; then \
        echo "Error: Cubesql installed version doesn't match"; \
        echo "Installed version:"; \
        cubesql -y; \
        echo "Required version:"; \
        echo "${CUBESQL_VERSION_REQUIRED}"; \
        false; \
    fi \
    && rm -rf /tmp/cubesql.tar.gz \
    && mkdir -p /data \
    && true

COPY entrypoint.sh /entrypoint.sh

WORKDIR /data

ENTRYPOINT ["/entrypoint.sh"]

STOPSIGNAL SIGQUIT

# Metadata
LABEL org.opencontainers.image.vendor="Jose Quintana" \
    org.opencontainers.image.url="https://github.com/joseluisq/docker-cubesql" \
    org.opencontainers.image.title="Docker cubeSQL 5" \
    org.opencontainers.image.description="A Linux Docker image for the cubeSQL server." \
    org.opencontainers.image.version="${CUBESQL_VERSION_REQUIRED}" \
    org.opencontainers.image.documentation="https://github.com/joseluisq/docker-cubesql"
