NAME	:= wolfhechel/data-analysis
TAG		:= $$(git rev-parse --short HEAD)
IMG		:= ${NAME}:${TAG}
LATEST	:= ${NAME}:latest

build:
	@docker build -t ${IMG} .
	@docker tag ${IMG} ${LATEST}

push:
	@docker push ${NAME}

.PHONY: build push
