HELM_VERSION	= $(shell cat VERSION)
IMAGE_VERSION	= $(HELM_VERSION)-$(shell git describe --always --tags)

default: build docker-push

build: Dockerfile
	docker build -t infoblox/helm:$(IMAGE_VERSION) .

docker-push: Dockerfile
	docker push infoblox/helm:$(IMAGE_VERSION)

version:
	@echo $(IMAGE_VERSION)

Dockerfile: Dockerfile.in VERSION
	sed "s/VERSION/$(HELM_VERSION)/g" Dockerfile.in > .Dockerfile
	mv .Dockerfile Dockerfile

clean:
	rm -f Dockerfile .Dockerfile
