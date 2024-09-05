HELM_VERSION	= $(shell cat VERSION)
IMAGE_VERSION	= $(HELM_VERSION)-$(shell git describe --always --tags)

default: build docker-push

docker-build-%: version=$(@:docker-build-%=%)
docker-build-%:
	docker build --build-arg VERSION=$(version) \
		-t infoblox/helm:$(version) .

docker-build: docker-build-$(HELM_VERSION) docker-build-3

docker-push-%: version=$(@:docker-push-%=%)
docker-push-%:
	docker push infoblox/helm:$(version)

docker-push: docker-push-$(HELM_VERSION) docker-push-3

version-major:
	@echo ${IMAGE_VERSION} | cut -d '.' -f 1

version:
	@echo $(IMAGE_VERSION)

clean:
	rm -f Dockerfile .Dockerfile

MOUNT_FLAGS=-v $(shell pwd):/pkg -w /pkg

test: test-$(HELM_VERSION) test-3

test-%: version=$(@:test-%=%)
test-%:
	docker run infoblox/helm:$(version) version
	# Root
	docker run -e NOAWS=1 $(MOUNT_FLAGS) infoblox/helm:$(version) lint /pkg/sample-chart-0.1.0.tgz
	# Non-root
	docker run -e NOAWS=1 -u 1002:1002 $(MOUNT_FLAGS) infoblox/helm:$(version) lint /pkg/sample-chart-0.1.0.tgz

test-aws: test-aws-$(HELM_VERSION) test-aws-3

test-aws-%: version=$(@:test-aws-%=%)
test-aws-%:
	docker run \
		-e AWS_REGION \
		-e AWS_ACCESS_KEY_ID \
		-e AWS_SECRET_ACCESS_KEY \
		-e AWS_SESSION_TOKEN \
		-u 1000:1000 \
		$(MOUNT_FLAGS) \
		infoblox/helm:$(version) \
		s3 push /pkg/sample-chart-0.1.0.tgz infobloxcto --dry-run
