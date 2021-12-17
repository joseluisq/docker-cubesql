FROM debian:11-slim

ARG CUBESQL_VERSION=5.8.0

ENV CUBESQL_VERSION=${CUBESQL_VERSION}

LABEL version="${CUBESQL_VERSION}" \
    description="Docker image for CubeSQL." \
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
    org.opencontainers.image.title="Docker cubeSQL" \
    org.opencontainers.image.description="A Linux Docker image for the cubeSQL server." \
    org.opencontainers.image.version="${CUBESQL_VERSION}" \
    org.opencontainers.image.documentation="https://github.com/joseluisq/docker-cubesql"
