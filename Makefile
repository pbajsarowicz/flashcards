.PHONY: run build test test-verbose test-coverage pre-deps install update setup
# TODO: automatically update .PHONY

run:
	poetry run python src/main.py

compile:
	toolchain build python3 kivy
	toolchain pip install -r toolchain_requirements.txt

build: compile
	@if [ -e "flashcards-ios" ]; then \
  		toolchain update flashcards-ios; \
  	else \
  	  	toolchain create Flashcards src; \
	fi

xcode:
	open flashcards-ios/flashcards.xcodeproj

test:
	poetry run pytest ${args}

test-verbose:
	poetry run pytest -s -vv ${args}

test-coverage:
	poetry run pytest --cov-report term --cov-report html --cov=src ${args}

d-run:
	xhost +localhost
	docker compose run --service-ports --rm app

d-build:
	docker compose build

d-test:
	docker compose run --rm app pytest ${args}

d-test-verbose:
	docker compose run --rm app pytest -s -vv ${args}

d-test-coverage:
	docker compose run --rm app pytest --cov-report term --cov-report html --cov=src ${args}

init_env_file:
	@if [ ! -e ".env" ]; then \
		cp .env.example .env >/dev/null 2>&1; \
	fi

pre-deps:
	pip install pre-commit
	pip install poetry
	poetry self add poetry-dotenv-plugin

install: pre-deps
	poetry install --no-root

update: pre-deps
	poetry lock
	pre-commit autoupdate

setup: pre-deps install init_env_file
	pre-commit install
