.PHONY: all test lint

all:

test: lint

lint:
	env LINT=true ./finnix-live-build

