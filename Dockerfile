ARG DEBIAN_VERSION
ARG GO_VERSION
ARG NODE_VERSION

FROM golang:$GO_VERSION-$DEBIAN_VERSION as builder
LABEL maintainer="Igor Sant'Ana <contato@igorsantana.com>"

RUN apt-get update && \
    apt-get install -y wget zip

ARG HUGO_VERSION

RUN wget https://github.com/gohugoio/hugo/archive/refs/tags/v$HUGO_VERSION.zip
RUN unzip v$HUGO_VERSION.zip
WORKDIR /go/hugo-$HUGO_VERSION

RUN CGO_ENABLED=1 go build -tags extended -o /go/hugo .

FROM debian:$DEBIAN_VERSION-slim as only-hugo
LABEL maintainer="Igor Sant'Ana <contato@igorsantana.com>"

COPY --from=builder /go/hugo /usr/bin

CMD ["hugo"]

FROM node:$NODE_VERSION-$DEBIAN_VERSION-slim as hugo-node
LABEL maintainer="Igor Sant'Ana <contato@igorsantana.com>"

COPY --from=builder /go/hugo /usr/bin

CMD ["hugo"]