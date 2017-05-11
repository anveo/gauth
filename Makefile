GO=CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go
TAG=latest
BIN=gauth
IMAGE=dailyhotel/$(BIN)

all: image
	docker push $(IMAGE):$(TAG)

build:
	$(GO) build -a -installsuffix cgo -o bin/$(BIN) .

image: build
	docker build -t $(IMAGE):$(TAG) .

.PHONY: clean

clean:
	rm bin/$(BIN)
