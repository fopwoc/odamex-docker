FROM debian:12 AS builder

LABEL MAINTAINER="Ilya Dobryakov <ilya.dobryakov@icloud.com>"

ENV VERSION=11.2.0
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y upgrade && \
    apt-get install -y curl libwxgtk3.2-dev deutex zlib1g-dev libasound2-dev cmake build-essential git libzstd-dev

RUN curl -LJO "https://github.com/odamex/odamex/releases/download/${VERSION}/odamex-src-${VERSION}.tar.gz" && \
    tar -zxvf odamex-*.tar.gz && \
    cd odamex-* && \
    cmake -DCMAKE_BUILD_TYPE=Release \
          -DCMAKE_INSTALL_PREFIX=/usr \
          -DBUILD_CLIENT=no \
		  -DBUILD_LAUNCHER=no \
		  -DBUILD_MASTER=no \
          -DBUILD_SERVER=yes \
          -DBUILD_SHARED_LIBS=OFF \
          -DCMAKE_C_FLAGS="-static -O2" \
          -DCMAKE_CXX_FLAGS="-static -O2 -static-libgcc -static-libstdc++" \
          -DCMAKE_EXE_LINKER_FLAGS="-static -s" \
          . && \
    make odasrv && make install

FROM debian:12-slim

COPY --from=builder /usr/share/odamex /usr/share/odamex
COPY --from=builder /usr/bin/odasrv /usr/bin/odasrv

RUN groupadd --gid 1000 doom && useradd --uid 1000 --gid doom --shell /sbin/nologin --create-home -d /doom doom
USER doom
WORKDIR /doom

EXPOSE 10666/udp
ENTRYPOINT ["/usr/bin/odasrv"]