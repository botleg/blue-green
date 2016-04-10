Blue-Green Deployment
===

This repository contains the files for the docker image [hanzel/blue-green](https://hub.docker.com/r/hanzel/blue-green/), that will create blue-green deployment. It uses nginx using consul template. It requires [consul](https://hub.docker.com/r/gliderlabs/consul-server/) as the key value store and [registrator](https://hub.docker.com/r/gliderlabs/registrator/) service running in each host. It works with docker swarm and multi-host networking.

Usage
---

Set the following environment variables:

* `BLUE_NAME`: The container name that we want as the blue service. Default: `blue`.
* `GREEN_NAME`: The container name that we want as the green service. Default: `green`.
* `LIVE`: The service that is in production initially. Default: `blue`.
* `CONSUL_URL`: URL endpoint for consul instance.

Docker Compose
---

Sample docker-compose.yml configuration is given below:

```
version: '2'

services:
  bg:
    image: hanzel/blue-green
    container_name: bg
    ports:
      - "80:80"
      - "8080:8080"
    environment:
      - CONSUL_URL=${IP}:8500
      - BLUE_NAME=blue
      - GREEN_NAME=green
      - LIVE=blue
    depends_on:
      - green
      - blue
    networks:
      - front-tier

  blue:
    image: hanzel/nginx-html:1
    ports:
      - "80"
    environment:
      - SERVICE_80_NAME=blue
    networks:
      - front-tier

  green:
    image: hanzel/nginx-html:2
    ports:
      - "80"
    environment:
      - SERVICE_80_NAME=green
    networks:
      - front-tier

networks:
  front-tier:
    driver: bridge
```