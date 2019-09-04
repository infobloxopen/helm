
version?=2.14.3

default:
	docker build -t infobloxcto/helm:$(version) \
		--build-arg AWS_REGION=$(AWS_REGION) \
		--build-arg AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID) \
		--build-arg AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY) \
		.
	docker push infobloxcto/helm:$(version)
