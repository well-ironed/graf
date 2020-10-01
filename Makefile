.PHONY:	docker setup compile

docker:
	docker build . -t codegraph

setup:
	mix local.hex --force
	cd priv/heb && npm install

compile: setup
	mix compile
