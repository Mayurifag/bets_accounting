all: cypress

cypress:
		docker-compose --file docker-compose-e2e.yml build --force-rm prodbuild
		docker-compose --file docker-compose-e2e.yml up --abort-on-container-exit --exit-code-from e2e

parallel:
		RAILS_ENV=test dip rake parallel:setup
		dip spec

prodbuild:
		docker-compose --file docker-compose-e2e.yml up --abort-on-container-exit --exit-code-from prodbuild prodbuild
