FROM ubuntu:noble

LABEL MAINTAINER="Ilya Dobryakov <ilya.dobryakov@icloud.com>"

ENV VERSION=11.0.0

RUN apt-get update && apt-get -y upgrade && \
    apt-get install -y curl libwxgtk3.2-dev deutex zlib1g-dev libasound2-dev cmake build-essential && \
    rm -rf /var/lib/apt/lists/* && \
    curl -LJO "https://github.com/odamex/odamex/releases/download/${VERSION}/odamex-src-${VERSION}.tar.gz" && \
    tar -zxvf odamex-*.tar.gz && \
    cd odamex-* && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr . && \
    make odasrv && make install && \
    rm -rf ./* && apt remove cmake build-essential -y && apt autoremove -y

RUN groupadd --gid 2000 doom && useradd --uid 2000 --gid doom --shell /bin/bash --create-home -d /doom doom
USER doom
WORKDIR /doom

EXPOSE 10666/udp
ENTRYPOINT ["/usr/bin/odasrv"]
