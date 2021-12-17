FROM debian:11-slim

ARG CUBESQL_VERSION=5.8.0

ENV CUBESQL_VERSION=${CUBESQL_VERSION}
ENV CUBESQL_PORT=4430
ENV CUBESQL_DATA=/data
ENV CUBESQL_SETTINGS=${CUBESQL_DATA}/cubesql.settings

LABEL version="${VERSION}" \
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
    && true

RUN set -eux \
    && mkdir -p /data \
    && true

WORKDIR /usr/local/bin

CMD /usr/local/bin/cubesql -p $CUBESQL_PORT -x $CUBESQL_DATA -s $CUBESQL_SETTINGS
