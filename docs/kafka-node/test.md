
# Running Tests

### Install Docker

On the Mac install [Docker for Mac](https://docs.docker.com/engine/installation/mac/).

### Start Docker and Run Tests

```bash
npm test
```

### Using different versions of Kafka

Achieved using the `KAFKA_VERSION` environment variable.

```bash
# Runs "latest" kafka on docker hub*
npm test

# Runs test against other versions:

KAFKA_VERSION=0.8 npm test

KAFKA_VERSION=0.9 npm test

KAFKA_VERSION=0.10 npm test

KAFKA_VERSION=0.11 npm test
```

*See Docker hub [tags](https://hub.docker.com/r/wurstmeister/kafka/tags/) entry for which version is considered `latest`.

### Stop Docker

```bash
npm run stopDocker
```