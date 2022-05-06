# odamex-docker
```odasrv``` in docker.

## How to use
I recommend you to use it in docker compose. Here is example. ```./data``` folder with all your wads and config. Logs by default also will be in this folder. Odasrv config examples you can get [here](https://github.com/odamex/odamex/tree/stable/config-samples).

```yaml
version: '3'

services:
  odamex-server:
    build: .
    volumes:
      - ./data:/doom/.odamex
    ports:
      - 10666:10666/udp
    entrypoint: "/usr/bin/odasrv -config /doom/.odamex/odasrv.cfg -file ./example.wad"
```
