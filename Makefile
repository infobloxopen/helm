
version?=2.14.3

default:
	docker build -t infobloxcto/helm:$(version) .
	docker push infobloxcto/helm:$(version)
