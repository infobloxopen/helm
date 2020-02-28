HELM_VERSION	= $(shell cat VERSION)
IMAGE_VERSION	= $(HELM_VERSION)-$(shell git describe --always --tags)

default: Dockerfile
	docker build -t infobloxcto/helm:$(IMAGE_VERSION) .
	docker push infobloxcto/helm:$(IMAGE_VERSION)

Dockerfile: Dockerfile.in VERSION
	sed "s/VERSION/$(HELM_VERSION)/g" Dockerfile.in > .Dockerfile
	mv .Dockerfile Dockerfile

clean:
	rm -f Dockerfile .Dockerfile
