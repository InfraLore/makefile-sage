# Fixture: Missing PHONY declarations for action targets

help:
	@echo "Available targets:"
	@echo "  setup - Install dependencies"
	@echo "  test  - Run tests"
	@echo "  build - Build application"
	@echo "  clean - Remove artifacts"

setup:
	npm install

test: setup
	npm test

build:
	npm run build

clean:
	rm -rf dist node_modules

# Missing .PHONY declarations - targets may not run if files with same names exist