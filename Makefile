SHELL := /bin/bash

.PHONY: bootstrap sync link install status

bootstrap:
	./scripts/bootstrap.sh

sync:
	./scripts/sync.sh macOS

link:
	./scripts/link.sh

install: bootstrap sync

status:
	@git status --short --branch
