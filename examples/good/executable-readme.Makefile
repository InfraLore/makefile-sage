# Example: Makefile as executable README for a web service

.PHONY: help dev logs deploy status clean

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

dev: ## Start development server with hot reload
	./scripts/dev.sh

logs: ## Follow application logs
	./scripts/logs.sh

deploy: ## Deploy to staging environment (requires confirmation)
	./scripts/deploy.sh staging

status: ## Check service health and deployment status
	./scripts/status.sh

clean: ## Remove temporary files and containers
	./scripts/clean.sh

.DEFAULT_GOAL := help