FROM golang:1.18-bullseye as builder
LABEL maintainer="Igor Sant'Ana"

ARG HUGO_VERSION

RUN apt-get update && \
    apt-get install -y wget zip

RUN wget https://github.com/gohugoio/hugo/archive/refs/tags/v$HUGO_VERSION.zip
RUN unzip v$HUGO_VERSION.zip
WORKDIR /go/hugo-$HUGO_VERSION

RUN go mod download
RUN go build -tags extended -o /go/hugo .

FROM debian:bullseye-slim as only-hugo
LABEL maintainer="Igor Sant'Ana"

COPY --from=builder /go/hugo /usr/bin

CMD ["hugo"]

FROM node:16-bullseye-slim as hugo-node
LABEL maintainer="Igor Sant'Ana"

COPY --from=builder /go/hugo /usr/bin

CMD ["hugo"]