# Docker cubeSQL [![devel](https://github.com/joseluisq/docker-cubesql/workflows/devel/badge.svg)](https://github.com/joseluisq/docker-cubesql/actions?query=workflow%3Adevel) ![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/joseluisq/cubesql/latest) [![Docker Image Size (tag)](https://img.shields.io/docker/image-size/joseluisq/cubesql/latest)](https://hub.docker.com/r/joseluisq/cubesql/tags) [![Docker Image](https://img.shields.io/docker/pulls/joseluisq/cubesql.svg)](https://hub.docker.com/r/joseluisq/cubesql/)

> A Linux [Docker](https://www.docker.com/) image for the [cubeSQL](https://www.sqlabs.com/cubesql) server. <br>
> _<small>**Note:** This is not an official Docker image.<small>_

It provides the [cubeSQL](https://www.sqlabs.com/cubesql) server using latest __Debian [11-slim](https://hub.docker.com/_/debian?tab=tags&page=1&name=11-slim)__ ([Bullseye](https://www.debian.org/News/2021/20210814)).

## cubeSQL License/Registration

You will need to register cubeSQL server.

1. [Request a key](https://www.sqlabs.com/cubesql_devkey) from sqlabs website.
2. Download [cubeSQL Admin](https://github.com/cubesql/cubeSQLAdmin), connect to cubeSQL and register your server.

*Note: The default server port is `4430`*

## Usage

Run a container

```sh
docker run --rm -it joseluisq/cubesql:latest
```

Or run the server using [Docker Compose](https://docs.docker.com/compose/)

```sh
docker-compose -f docker-compose.sample.yml up
# [+] Running 1/1
# Container docker-cubesql_cubesql-server_1  Recreated
# Attaching to cubesql-server_1
# cubesql-server_1  | CubeSQL Server version 5.8.0 64bit mode, Build Date Sep 26 2020 (SQLite Engine 3.33.0), TSL Library is LibreSSL 3.1.4
# cubesql-server_1  |
```

Or extend this image using your own `Dockerfile`

```Dockerfile
FROM joseluisq/cubesql:latest
# ....
```

## Environment variables

The image provides the following environment variables for setup with the following default values.

- `CUBESQL_PORT`: `4430`
- `CUBESQL_DATA`: `/data`
- `CUBESQL_SETTINGS`: `/data/cubesql.settings`
- `CUBESQL_SSL_ONLY`: `false`
- `CUBESQL_SSL_CERTIFICATE`:
- `CUBESQL_CA_ROOT_CERTIFICATE`:
- `CUBESQL_MAX_SHARED_DATABASES`:
- `CUBESQL_DEBUG_MODE`: `NONE`
- `CUBESQL_LOG_FORMAT`: `CONSOLE`
- `CUBESQL_LOG_VERBOSITY`: `NONE`
- `CUBESQL_OPTS`:

`CUBESQL_OPTS` is a custom env to pass extra arguments to `cubesql` server which are not listed above.

You can see the all cubeSQL options typing:

```sh
docker run --rm -it joseluisq/cubesql:latest cubesql -h
# usage: cubesql [options]
# Available options are:
#   -h                      print usage and exit
#   -y                      print version and exit
#   -z                      do not load disabled logins table
#   -q                      enable SSL only connections mode
#   -t nthreads             set default startup working threads
#   -o ndatabases           set max number of shared databases
#   -l backlog              backlog size to be specified in the listen function
#   -p server_port          server port
#   -i ip_address           ip address used to bind
#   -f log_format           log format, values can be TEXT, SQLITE and CONSOLE
#   -v log_verbosity        log verbosity, values can be NONE, SQL_ERRORS or SQL_COMMANDS
#   -g debug_mode           debug mode, values can be NONE, FILE, CONSOLE, SYSTEM
#   -d db_path              full path to databases folder
#   -r restore_path         full path to restore folder
#   -b backup_path          full path to backup folder
#   -n manual_backup_path   full path to manual backup folder
#   -w ssl_crypto_path      full path to ssl and crypto libraries (in the form "ssl_libpath|crypto_libpath")
#   -u upload_path          full path to upload folder
#   -s settings_file        full path to settings file
#   -c config_file          full path to JSON startup config file
#   -e log_file             full path to log file
#   -x data_path            full path to the main data folder used by the server
#   -m ssl_certificate      full path to the SSL cerfificate file
#   -a ca_root_certificate  full path to the SSL CA root certiticate to enable client peer verification
```

## Enable SSL only connections mode

First set up the cubesql server using `CUBESQL_SSL_ONLY=true` environment variable in order to accept **only** SSL connections.

Then on client side, for example [cubeSQL Admin](https://github.com/cubesql/cubeSQLAdmin) to connect to the server make sure to use encryption SSL.

![image](https://user-images.githubusercontent.com/1700322/147923364-549c7097-b240-4527-bff5-bbb165a8496f.png)

For more details take a look at [How to create a SSL certificate for localhost](https://www.sqlabs.com/blog/2020/09/how-to-create-a-ssl-certificate-for-localhost/)

## Docker Compose Example

A working [Docker Compose](https://docs.docker.com/compose/) example can be found on [docker-compose.sample.yml](docker-compose.sample.yml)

## Contributions

Unless you explicitly state otherwise, any contribution intentionally submitted for inclusion in current work by you, as defined in the Apache-2.0 license, shall be dual licensed as described below, without any additional terms or conditions.

Feel free to send some [Pull request](https://github.com/joseluisq/docker-cubesql/pulls) or file an [issue](https://github.com/joseluisq/docker-cubesql/issues).

## License

This work is primarily distributed under the terms of both the [MIT license](LICENSE-MIT) and the [Apache License (Version 2.0)](LICENSE-APACHE).

© 2021-present [Jose Quintana](https://joseluisq.net)
