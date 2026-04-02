# Anti-pattern: No discoverability - user has to read source to understand options

build:
	docker build -t myapp .

run:
	docker run -p 8080:8080 myapp

stop:
	docker stop myapp

deploy-stg:
	kubectl apply -f k8s/staging/

deploy-prod:
	kubectl apply -f k8s/production/

test-unit:
	npm run test

test-e2e:
	cypress run

db-migrate:
	npm run migrate

db-seed:
	npm run seed

logs:
	kubectl logs -f deployment/myapp

clean:
	docker system prune -f