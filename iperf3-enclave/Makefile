prog := iperf3-enclave
version := $(shell git describe --tag --dirty)
image_tag := $(prog):$(version)
image_tar := $(prog)-$(version)-kaniko.tar
image_eif := $(image_tar:%.tar=%.eif)

.PHONY: all
all: run

.PHONY: image
image: $(image_tar)

$(image_tar): Dockerfile start.sh
	docker run \
		-v $(PWD):/workspace \
		gcr.io/kaniko-project/executor:v1.9.2 \
		--reproducible \
		--no-push \
		--tarPath $(image_tar) \
		--destination $(image_tag) \
		--custom-platform linux/amd64

$(image_eif): $(image_tar)
	docker load -i $<
	nitro-cli build-enclave \
		--docker-uri $(image_tag) \
		--output-file $(image_eif)

.PHONY: terminate
terminate:
	nitro-cli terminate-enclave \
		--all

.PHONY: run
run: terminate $(image_eif)
	nitro-cli run-enclave \
		--cpu-count 2 \
		--memory 600 \
		--enclave-cid 4 \
		--eif-path $(image_eif) \
		--attach-console

.PHONY: clean
clean:
	rm -f $(image_tar) $(image_eif)
