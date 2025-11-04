# astree-docker

Rocky Linux docker image with necessary system libraries preinstalled to run AbsInt Astrée

Note: This docker does **not** include the tool itself, just an environment, where all necessary system
dependencies are fulfilled.

## Usage

```sh
$ docker run \
-v $(pwd):/project  \
-v <your-astree-installation>:/opt/astree \
--user $(id -u):$(id -g) \
-e AI_LICENSE_TLS=... \
--rm -it clemensk845/astree-docker:25.10 /bin/bash
```

## Build Instructions

```sh
docker built -t astree-docker:25.10 .
```

## Upload instructions

```sh
docker image push docker.io/clemensk845/astree-docker:25.10
```

## ToDos

- this image seems to be pretty fat (>1 GB), we could offer a "minimal" image
