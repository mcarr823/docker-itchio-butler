# Butler Docker image

[![Docker Image amd64](https://github.com/mcarr823/docker-itchio-butler/actions/workflows/docker-amd64.yml/badge.svg)](https://github.com/mcarr823/docker-itchio-butler/actions/workflows/docker-amd64.yml)
[![Docker Image arm64](https://github.com/mcarr823/docker-itchio-butler/actions/workflows/docker-aarch64.yml/badge.svg)](https://github.com/mcarr823/docker-itchio-butler/actions/workflows/docker-aarch64.yml)

This is an unofficial docker image for [Itch.io's butler program](https://github.com/itchio/butler).

Builds are provided for both AMD64 and ARM64/AARCH64.

The program is built from source, since Itch does not provide an ARM64 binary of the butler program.

## Volumes

The docker image requires a few volumes to work as intended.

- an input directory in which your game files reside
- a config directory for storing your login state (so you don't need to login again every time)
- a cache directory for storing miscellaneous operational files. This is optional

## Tags

There are two tags provided, one for each supported architecture.

- ghcr.io/mcarr823/docker-itchio-butler:amd64
- ghcr.io/mcarr823/docker-itchio-butler:arm64

## Examples

### Run the program and print out its version

`docker run -v ./in:/home/butler/in/ -v ./config:/home/butler/.config/itch/ ghcr.io/mcarr823/docker-itchio-butler:amd64 version`

This will likely print out "head, no build date", since we're compiling from source.

### Do the same, but with compose

`docker compose run butler version`

This assumes you've copied the docker-compose.yml file from this repository.

### Initiate the login process

`docker compose run butler login`

### Push a game build to Itch

`docker compose run butler push /home/butler/in/MyGame.zip myrepo/mygame:tags`

MyGame.zip would reside in the input folder (./in/ by default).

myrepo/mygame:tags should correspond to whatever your username, game, and desired tags are for the build.


