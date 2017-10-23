# terraform Docker Container
### Usage
This repository automatically builds containers for using the [`terraform`](https://terraform.io) command line program. It contains two distinct varieties of build, a `light` version, which just contains the binary, and a `full` version while compiles the binary from source inside the container before exposing it for use. Which you want will depend on use.


## Logging in to Docker Hub

If you want to push a new build of terraform, make sure you do `docker login` beforehand as a valid user of the `gobinaris` team in Docker Hub. Ask Assaf for the credentials (or reset them - the email is services@binaris.com).


##### `full`
The `full` version of this container contains all of the source code found in the parent [repository](https://github.com/hashicorp/terraform). Using [Google's official `golang` image](https://hub.docker.com/_/golang/) as a base, this container will copy the source from the `master` branch, build the binary, and expose it for running. Since the build is done on [Docker Hub](https://hub.docker.com/r/hashicorp), the container is ready for use. Because all build artifacts are included, it should be quite a bit larger than the `light` image. This version of the container is useful for development or debugging.

You can use this version with the following:
```shell
docker run -i -t -v $(pwd):/app/ -w /app/ hashicorp/terraform:full <command>
```

For example:
Initialize the plugins (You will only need to do this once)
```shell
docker run -i -t -v $(pwd):/app/ -w /app/ hashicorp/terraform:full init
```

```shell
docker run -i -t -v $(pwd):/app/ -w /app/ hashicorp/terraform:full plan main.tf
```
