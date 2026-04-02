# Fixture: Makefile with syntax errors and missing declarations

default:
	echo "Running default target"

test:
	npm test
	if [ $? -ne 0 ]; then
		echo "Tests failed"
		exit 1
	fi

deploy
	kubectl apply -f deployment.yaml
	kubectl rollout status deployment/myapp

clean:
    rm -rf dist/
	docker system prune

.PHONY test deploy