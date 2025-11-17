# -------- VARIABLES --------
APP_MODULE=poppin_server.main:app
HOST=127.0.0.1
PORT=8000

# -------- COMMANDS --------

## Install all dependencies
install:
	poetry install

## Run FastAPI in dev mode
dev:
	poetry run uvicorn $(APP_MODULE) --reload --host $(HOST) --port $(PORT)

## Run FastAPI in production mode (no reload)
start:
	poetry run uvicorn $(APP_MODULE) --host $(HOST) --port $(PORT)

## Format & lint
format:
	poetry run black src/poppin_server
	poetry run isort src/poppin_server

lint:
	poetry run black --check src/poppin_server
	poetry run isort --check-only src/poppin_server
	poetry run pylint src/poppin_server || true

## Run tests
test:
	poetry run pytest -q

## Build a wheel
build:
	poetry build

## Remove cache & virtualenv
clean:
	rm -rf __pycache__ .pytest_cache
	poetry env remove --all || true

## Show available commands
help:
	@grep -E '^[a-zA-Z_-]+:.*?##' Makefile | sed 's/:.*##/: /'
