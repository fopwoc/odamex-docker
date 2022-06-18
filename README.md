# odamex-docker
`odasrv` in docker.

### docker-compose
I recommend you to use it in docker compose. Here is example. `/path/to/data` folder with all your wads and config. Logs by default also will be in this folder. `odasrv` config examples you can get [here](https://github.com/odamex/odamex/tree/stable/config-samples).

```yaml
version: '3'

services:
  odamex-server:
    image: acetylsalicylicacid/odamex-docker:latest
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
   acetylsalicylicacid/odamex-docker:latest \
   --entrypoint "/usr/bin/odasrv -config /doom/.odamex/odasrv.cfg -file example.wad example2.wad"
```
