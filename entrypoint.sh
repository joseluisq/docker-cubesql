#!/bin/sh

set -e

# Check if incomming command contains flags.
if [ "${1#-}" != "$1" ]; then
    set -- cubesql "$@"
else
    # Default entry point
    if [ "$1" = "" ]; then
        # Default values
        X_PORT=4430
        X_DATA=/data
        X_SETTINGS=${X_DATA}/cubesql.settings
        X_DEBUG_MODE=NONE
        X_LOG_FORMAT=CONSOLE
        X_LOG_VERBOSITY=NONE
        X_OPTS=""

        # Settings initialization
        if [ -z "$CUBESQL_PORT" ]; then export CUBESQL_PORT=$X_PORT; fi
        if [ -z "$CUBESQL_DATA" ]; then export CUBESQL_DATA=$X_DATA; fi
        if [ -z "$CUBESQL_SETTINGS" ]; then export CUBESQL_SETTINGS=$X_SETTINGS; fi

        if [ -n "$CUBESQL_SSL_ONLY" ] && [ "$CUBESQL_SSL_ONLY" = "true" ]; then X_OPTS="$X_OPTS -q"; fi

        if [ -n "$CUBESQL_SSL_CERTIFICATE" ]; then X_OPTS="$X_OPTS -m=$CUBESQL_SSL_CERTIFICATE"; fi

        if [ -n "$CUBESQL_CA_ROOT_CERTIFICATE" ]; then X_OPTS="$X_OPTS -a=$CUBESQL_CA_ROOT_CERTIFICATE"; fi

        if [ -n "$CUBESQL_MAX_SHARED_DATABASES" ]; then X_OPTS="$X_OPTS -o=$CUBESQL_MAX_SHARED_DATABASES"; fi

        if [ -z "$CUBESQL_DEBUG_MODE" ]; then export CUBESQL_DEBUG_MODE=$X_DEBUG_MODE; fi
        X_OPTS="$X_OPTS -g=$CUBESQL_DEBUG_MODE"

        if [ -z "$CUBESQL_LOG_FORMAT" ]; then export CUBESQL_LOG_FORMAT=$X_LOG_FORMAT; fi
        X_OPTS="$X_OPTS -f=$CUBESQL_LOG_FORMAT"

        if [ -z "$CUBESQL_LOG_VERBOSITY" ]; then export CUBESQL_LOG_VERBOSITY=$X_LOG_VERBOSITY; fi
        X_OPTS="$X_OPTS -v=$CUBESQL_LOG_VERBOSITY"

        # cubeSQL custom options
        if [ -n "$CUBESQL_OPTS" ]; then X_OPTS="$X_OPTS $CUBESQL_OPTS"; fi

        set -- cubesql -p ${CUBESQL_PORT} -x ${CUBESQL_DATA} -s ${CUBESQL_SETTINGS} ${X_OPTS}
    fi
fi

exec "$@"
