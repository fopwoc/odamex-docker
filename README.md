# odamex-docker

[![Build](https://github.com/fopwoc/odamex-docker/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/fopwoc/odamex-docker/actions/workflows/docker-publish.yml)

`odasrv` in docker.

### docker-compose

Put your wads and config in `/path/to/data`. Logs by default will also appear here. `odasrv` config examples you can get [here](https://github.com/odamex/odamex/tree/stable/config-samples).

```yaml
version: '3'

services:
  odamex-server:
    image: ghcr.io/fopwoc/odamex-docker:latest
    volumes:
      - /path/to/data:/doom/.odamex
    ports:
      - 10666:10666/udp
    entrypoint: "/usr/bin/odasrv -config /doom/.odamex/odasrv.cfg -file example.wad example2.wad"
```

### docker run

```shell
docker run -d \
   -v "/path/to/data:/home/doom/.odamex" \
   ghcr.io/fopwoc/odamex-docker:latest \
   --entrypoint "/usr/bin/odasrv -config /doom/.odamex/odasrv.cfg -file example.wad example2.wad"
```

