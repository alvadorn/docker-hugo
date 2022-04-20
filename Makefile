BASE_IMAGE=alvadorn/hugo

all: cross-build-hugo-node cross-build-only-hugo

build-only-hugo:
	docker build --build-arg HUGO_VERSION="$(HUGO_VERSION)" -t $(BASE_IMAGE):$(HUGO_VERSION)-bullseye --target only-hugo .

push-only-hugo: build-only-hugo
	docker push $(BASE_IMAGE):$(HUGO_VERSION)-bullseye

cross-build-only-hugo:
	docker buildx build --platform linux/amd64,linux/arm64 --build-arg HUGO_VERSION="$(HUGO_VERSION)" -t $(BASE_IMAGE):$(HUGO_VERSION)-bullseye --push --target only-hugo .

build-hugo-node:
	docker build --build-arg HUGO_VERSION=$(HUGO_VERSION) -t $(BASE_IMAGE):$(HUGO_VERSION)-node16-bullseye .

push-hugo-node: build-hugo-node
	docker push $(BASE_IMAGE):$(HUGO_VERSION)-node16-bullseye

cross-build-hugo-node:
	docker buildx build --platform linux/amd64,linux/arm64 --build-arg HUGO_VERSION=$(HUGO_VERSION) -t $(BASE_IMAGE):$(HUGO_VERSION)-node16-bullseye --push .
