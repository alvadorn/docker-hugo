# Docker Hugo

This image is a build of (Hugo)[https://gohugo.io].

It is available on https://hub.docker.com/r/alvadorn/hugo

## How to build
To build this image, do: 

```sh
HUGO_VERSION=<version> make build-only-hugo
HUGO_VERSION=<version> make build-hugo-node
```