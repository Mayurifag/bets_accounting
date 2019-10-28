all: test

test:
		docker-compose --file docker-compose-e2e.yml build --force-rm prodbuild
		docker-compose --file docker-compose-e2e.yml up --abort-on-container-exit --exit-code-from e2e
