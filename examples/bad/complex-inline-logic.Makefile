# Anti-pattern: Complex inline logic that should be extracted to scripts

deploy:
	@if [ "$(ENV)" = "" ]; then \
		echo "ERROR: ENV variable not set"; \
		echo "Usage: make deploy ENV=staging|production"; \
		exit 1; \
	fi; \
	if [ "$(ENV)" = "production" ]; then \
		echo "Production deployment requires additional checks..."; \
		if [ ! -f "production.key" ]; then \
			echo "ERROR: production.key not found"; \
			exit 1; \
		fi; \
		if [ "$$(git rev-parse --abbrev-ref HEAD)" != "main" ]; then \
			echo "ERROR: Production deploys must be from main branch"; \
			exit 1; \
		fi; \
		read -p "Are you sure you want to deploy to production? [y/N] " -n 1 -r; \
		echo; \
		if [[ ! $$REPLY =~ ^[Yy]$$ ]]; then \
			echo "Deployment cancelled"; \
			exit 1; \
		fi; \
	fi; \
	echo "Deploying to $(ENV)..."; \
	docker build -t myapp:$(ENV) .; \
	if [ "$(ENV)" = "staging" ]; then \
		docker tag myapp:$(ENV) registry.example.com/myapp:staging-$$(date +%Y%m%d-%H%M%S); \
	else \
		docker tag myapp:$(ENV) registry.example.com/myapp:latest; \
		docker tag myapp:$(ENV) registry.example.com/myapp:$$(git rev-parse --short HEAD); \
	fi; \
	docker push registry.example.com/myapp:$(ENV)

test:
	@for test_type in unit integration e2e; do \
		echo "Running $$test_type tests..."; \
		if [ "$$test_type" = "unit" ]; then \
			npm run test:unit; \
		elif [ "$$test_type" = "integration" ]; then \
			docker-compose up -d db redis; \
			sleep 5; \
			npm run test:integration; \
			docker-compose down; \
		else \
			if [ ! -f ".env.test" ]; then \
				cp .env.example .env.test; \
			fi; \
			docker-compose -f docker-compose.test.yml up -d; \
			sleep 10; \
			npm run test:e2e; \
			docker-compose -f docker-compose.test.yml down; \
		fi; \
		if [ $$? -ne 0 ]; then \
			echo "$$test_type tests failed!"; \
			exit 1; \
		fi; \
	done; \
	echo "All tests passed!"