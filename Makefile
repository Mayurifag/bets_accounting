all: cypress

cypress:
		docker-compose --file docker-compose-e2e.yml build
		docker-compose --file docker-compose-e2e.yml up --abort-on-container-exit --exit-code-from e2e

parallel:
		RAILS_ENV=test dip rake parallel:setup
		dip spec

prodbuild:
		docker-compose --file docker-compose-e2e.yml up --abort-on-container-exit --exit-code-from prodbuild prodbuild

yml:
		docker run --rm -ti -v $(PWD):/workdir giantswarm/yamllint -d relaxed .

report:
		dip report
		xdg-open ./frontend/dist/report.html
