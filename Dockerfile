FROM debian:7-slim

ENV CUBESQL_VERSION 561

RUN apt-get update && apt-get install -y wget
RUN mkdir /opt/cubesql
RUN wget --progress=bar:force --no-check-certificate https://www.sqlabs.com/download/cubesql/${CUBESQL_VERSION}/cubesql_linux64bit.tgz

RUN gzip -dc cubesql_linux64bit.tgz | tar xvf -
RUN mv cubesql/data/core/Linux/cubesql /opt/cubesql/cubesql
RUN rm cubesql_linux64bit.tgz && rm -R cubesql

WORKDIR /opt/cubesql

CMD ["/opt/cubesql/cubesql", "-f", "CONSOLE"]
