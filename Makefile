TAG = django-q2-build
DOCKERFILE = ./Dockerfile.build
IMAGE_STAMP = .docker-$(TAG).stamp

# GNU/Make requires an actual file to be tracked
$(IMAGE_STAMP): $(DOCKERFILE)
	docker build -f $(DOCKERFILE) -t $(TAG) .
	docker image inspect $(TAG) --format='{{.Id}}' > $(IMAGE_STAMP)

docker-build: $(IMAGE_STAMP)

build: docker-build
	docker run -i --rm -v $$PWD:/build $(TAG)
