

VERSION=$(shell cat VERSION)

default: Dockerfile
	docker build -t infobloxcto/helm:$(VERSION) \
		--build-arg AWS_REGION=$(AWS_REGION) \
		--build-arg AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID) \
		--build-arg AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY) \
		.
	docker push infobloxcto/helm:$(VERSION)

Dockerfile: Dockerfile.in VERSION
	sed "s/VERSION/$(VERSION)/g" Dockerfile.in > .Dockerfile
	mv .Dockerfile Dockerfile

clean:
	rm -f Dockerfile .Dockerfile

