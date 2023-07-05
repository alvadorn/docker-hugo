# Docker Hugo

This image is a build of [Hugo](https://gohugo.io) with extended options.

It is available at https://hub.docker.com/r/alvadorn/hugo

## How to build

To build this image, do the following: 

```sh
HUGO_VERSION=<version> make build-only-hugo
HUGO_VERSION=<version> make build-hugo-node
```