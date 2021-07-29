WP_IMAGE := wordoc/wordoc-cms
TAG_LOCAL := latest

#| Assign ARGS variable to tokens after first given target
#| and then evaluate them into new noop targets if require-args.
#| Example: make <target> <ARGS>
ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
$(eval $(ARGS):;@:)

.PHONY: require-args
require-args:
ifndef ARGS
	$(error Missing target args, i.e. make <target> <arg>)
endif

.PHONY: build          # Example: make build dev  / make build live
build: require-args
	DOCKER_BUILDKIT=1 \
	docker build \
		-t $(WP_IMAGE):$(TAG_LOCAL) \
		--build-arg SOURCE_COMMIT=$(shell git rev-parse HEAD) \
		-f Dockerfile \
		.


.PHONY: push	         # Example: make push dev  / make push live
push: require-args
	docker tag $(WP_IMAGE):$(TAG_LOCAL) $(WP_IMAGE):$(ARGS)
	docker push $(WP_IMAGE):$(ARGS)


.PHONY: build-push    # OR run this for both build & push: make build-push dev
build-push: require-args build push
