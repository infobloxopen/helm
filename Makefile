

VERSION=$(shell cat VERSION)
HELM_VERSION=$(shell cat VERSION | awk -F'-' '{print $$1}')

default: AWS_ACCESS_KEY_ID?=`aws configure get aws_access_key_id`
default: AWS_SECRET_ACCESS_KEY?=`aws configure get aws_secret_access_key`
default: AWS_REGION?=`aws configure get region`
default: Dockerfile
	docker build -t infoblox/helm:$(VERSION) \
		--build-arg AWS_REGION=$(AWS_REGION) \
		--build-arg AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID) \
		--build-arg AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY) \
		.
	docker push infoblox/helm:$(VERSION)

Dockerfile: Dockerfile.in VERSION
	echo ${HELM_VERSION}
	sed "s/VERSION/$(HELM_VERSION)/g" Dockerfile.in > .Dockerfile
	mv .Dockerfile Dockerfile

clean:
	rm -f Dockerfile .Dockerfile
