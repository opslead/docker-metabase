# Metabase Container Image

[![Docker Stars](https://img.shields.io/docker/stars/opslead/metabase.svg?style=flat-square)](https://hub.docker.com/r/opslead/metabase) 
[![Docker Pulls](https://img.shields.io/docker/pulls/opslead/metabase.svg?style=flat-square)](https://hub.docker.com/r/opslead/metabase)

#### Docker Images

- [GitHub actions builds](https://github.com/opslead/docker-metabase/actions) 
- [Docker Hub](https://hub.docker.com/r/opslead/metabase)


#### Environment Variables
When you start the Metabse image, you can adjust the configuration of the instance by passing one or more environment variables either on the docker-compose file or on the docker run command line. The following environment values are provided to custom Metabse:

| Variable                  | Default Value | Description                     |
| ------------------------- | ------------- | ------------------------------- |
| `JAVA_ARGS`               |               | Configure JVM params            |
| `MB_DB_TYPE`              |               | Database type                   |
| `MB_DB_DBNAME`            |               | Database name                   |
| `MB_DB_PORT`              |               | Database port                   |
| `MB_DB_USER`              |               | Database user                   |
| `MB_DB_PASS`              |               | Database password               |
| `MB_DB_HOST`              |               | Database host                   |


#### Run the Service

```bash
docker service create --name metabase \
  -p 8080:8080 \
  -e JAVA_ARGS="-Xms2G -Xmx6G" \
  opslead/metabase:latest
```

When running Docker Engine in swarm mode, you can use `docker stack deploy` to deploy a complete application stack to the swarm. The deploy command accepts a stack description in the form of a Compose file.

```bash
docker stack deploy -c metabase-stack.yml metabase
```

Compose file example:
```
version: "3.8"
services:
  metabase:
    image: opslead/metabase:latest
    ports:
      - 8080:8080
    deploy:
      replicas: 1
      restart_policy:
        condition: on-failure
      environment:
        - JAVA_ARGS=-Xms2G -Xmx6G
        - MB_DB_TYPE=postgres
        - MB_DB_DBNAME=metabaseappdb
        - MB_DB_PORT=5432
        - MB_DB_USER=username
        - MB_DB_PASS=password
        - MB_DB_HOST=localhost

```

# Contributing
We'd love for you to contribute to this container. You can request new features by creating an [issue](https://github.com/opslead/docker-metabase/issues), or submit a [pull request](https://github.com/opslead/docker-metabase/pulls) with your contribution.

# Issues
If you encountered a problem running this container, you can file an [issue](https://github.com/opslead/docker-metabase/issues). For us to provide better support, be sure to include the following information in your issue:

- Host OS and version
- Docker version
- Output of docker info
- Version of this container
- The command you used to run the container, and any relevant output you saw (masking any sensitive information)
