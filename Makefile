.PHONY:	docker setup compile

DOCKER_TAG ?= codegraph

docker:
	docker build . -t $(DOCKER_TAG)

setup:
	mix local.hex --force
	cd priv/heb && npm install

compile: setup
	mix compile
