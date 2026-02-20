SHELL := /bin/bash

.PHONY: bootstrap link sync autosync-install autosync-remove status

bootstrap:
	./scripts/bootstrap.sh

link:
	./scripts/link.sh

sync:
	./scripts/sync.sh macOS

autosync-install:
	./scripts/install-autosync.sh

autosync-remove:
	./scripts/remove-autosync.sh

status:
	@git status --short --branch
