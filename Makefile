.PHONY: run build test test-verbose test-coverage pre-deps install update setup

# TODO: automatically update .PHONY

run:
	xhost +localhost
	docker compose run --service-ports --rm app

build:
	docker compose build

test:
	docker compose run --rm app pytest ${args}

test-verbose:
	docker compose run --rm app pytest -s -vv ${args}

test-coverage:
	docker compose run --rm app pytest --cov-report term --cov-report html --cov=src ${args}

init_env_file:
	@if [ ! -e ".env" ]; then \
		cp .env.example .env >/dev/null 2>&1; \
	fi

pre-deps:
	pip install poetry
	pip install pre-commit

install: pre-deps
	poetry install --no-root

update: pre-deps
	poetry lock
	pre-commit autoupdate

setup: pre-deps install init_env_file
	pre-commit install
