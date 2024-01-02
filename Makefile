run:
	docker compose -f src/docker-compose.yml run --service-ports --rm

test:
	docker compose -f src/docker-compose.yml run --rm app pytest ${args}

test-verbose:
	docker compose -f src/docker-compose.yml run --rm app pytest -s -vv ${args}

test-coverage:
	docker compose -f src/docker-compose.yml run --rm app pytest --cov-report term --cov-report html --cov=src ${args}

pre-deps:
	pip install poetry
	pip install pre-commit

install-deps: pre-deps
	poetry install

update-deps: pre-deps
	poetry lock --no-update
	pre-commit autoupdate

setup: pre-deps
	pre-commit install
