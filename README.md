# Docker CubeSQL

> A Linux [Docker](https://www.docker.com/) image for the [CubeSQL](https://www.sqlabs.com/cubesql) server. <br>
> _**Note:** This is not an official Docker image._

This Docker image provides the [CubeSQL](https://www.sqlabs.com/cubesql) server using latest __Debian [11-slim](https://hub.docker.com/_/debian?tab=tags&page=1&name=11-slim)__ ([Bullseye](https://www.debian.org/News/2021/20210814)).

## cubeSQL License/Registration

You will need to register cubeSQL server.

1. [Request a key](https://www.sqlabs.com/cubesql_devkey) from sqlabs website.
2. Download [cubeSQL Admin](https://github.com/cubesql/cubeSQLAdmin), connect to cubeSQL and register your server.

*Note: The default server port is `4430`*

## Usage

Run a container

```sh
docker run --rm -it joseluisq/docker-cubesql:latest
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
FROM joseluisq/docker-cubesql:latest
# ....
```

## Environment variables

The image provides the following environment variables for setup with the following default values.

- `CUBESQL_PORT`: `4430`
- `CUBESQL_DATA`: `/data`
- `CUBESQL_SETTINGS`: `/data/cubesql.settings`

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
