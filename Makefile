BASE_IMAGE=alvadorn/hugo
DEBIAN_VERSION?=bookworm
NODE_VERSION?=18
GO_VERSION=1.19
PLATFORMS=linux/amd64,linux/arm64,linux/arm/v7

ifdef $(LATEST)
	echo "teste"
endif

all: cross-build-hugo-node cross-build-only-hugo

# build-only-hugo:
# 	docker build --build-arg HUGO_VERSION="$(HUGO_VERSION)"  -t $(BASE_IMAGE):$(HUGO_VERSION)-$(DEBIAN_VERSION) --target only-hugo .

# push-only-hugo: build-only-hugo
# 	docker push $(BASE_IMAGE):$(HUGO_VERSION)-bullseye ,linux/arm64

cross-build-only-hugo:
	TAGS=""
ifdef LATEST
	TAGS="-t $(BASE_IMAGE):latest -t $(BASE_IMAGE):$(DEBIAN_VERSION)"
	@echo $(TAGS)
endif

	docker buildx build --platform $(PLATFORMS) \
		-t $(BASE_IMAGE):$(HUGO_VERSION)-$(DEBIAN_VERSION) $(TAGS) \
		--build-arg DEBIAN_VERSION="$(DEBIAN_VERSION)" \
		--build-arg NODE_VERSION="$(NODE_VERSION)" \
		--build-arg GO_VERSION="$(GO_VERSION)" \
		--build-arg HUGO_VERSION="$(HUGO_VERSION)" \
		--push --target only-hugo .

# build-hugo-node:
# 	docker build --build-arg HUGO_VERSION=$(HUGO_VERSION) -t $(BASE_IMAGE):$(HUGO_VERSION)-node$(NODE_VERSION)-$(DEBIAN_VERSION) .

# push-hugo-node: build-hugo-node
# 	docker push $(BASE_IMAGE):$(HUGO_VERSION)-node$(NODE_VERSION)-$(DEBIAN_VERSION)

cross-build-hugo-node:
	TAGS=""
ifdef LATEST
	TAGS="-t $(BASE_IMAGE):node -t $(BASE_IMAGE):node$(NODE_VERSION) -t $(BASE_IMAGE):node$(NODE_VERSION)-$(DEBIAN_VERSION)"
	@echo $(TAGS)
endif

	docker buildx build --platform $(PLATFORMS) \
		-t $(BASE_IMAGE):$(HUGO_VERSION)-node$(NODE_VERSION)-$(DEBIAN_VERSION) $(TAGS) \
		--build-arg DEBIAN_VERSION="$(DEBIAN_VERSION)" \
		--build-arg NODE_VERSION="$(NODE_VERSION)" \
		--build-arg GO_VERSION="$(GO_VERSION)" \
		--build-arg HUGO_VERSION="$(HUGO_VERSION)" \
		--push .

	