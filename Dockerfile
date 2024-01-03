FROM python:3.12-slim as base
ENV PYTHONUNBUFFERED 1 \
    POETRY_HOME="/opt/poetry"

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    POETRY_VERSION=1.6.1 \
    # make poetry install to this location
    POETRY_HOME="/opt/poetry" \
    # make poetry create the virtual environment in the project's root it gets named `.venv`
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    POETRY_NO_INTERACTION=1 \
    # Paths - this is where requirements and virtual environment will live
    PYDEPS_PATH="/opt/pydeps" \
    VENV_PATH="/opt/pydeps/.venv"

# Prepend poetry and venv to path
ENV PATH="$POETRY_HOME/bin:$VENV_PATH/bin:$PATH"



# `builder` stage is used to build deps and create virtual environment
FROM base as builder
RUN apt-get update && apt-get install --no-install-recommends -y \
        build-essential \
        curl

# Install poetry - respects $POETRY_VERSION and $POETRY_HOME
RUN curl -sSL https://install.python-poetry.org | python3 -

# Copy project requirement files here to ensure they will be cached.
WORKDIR $PYDEPS_PATH
COPY poetry.lock pyproject.toml ./

# Install only main dependencies - uses $POETRY_VIRTUALENVS_IN_PROJECT internally
RUN poetry install --only main


# Dev image
FROM builder AS dev

# Copy in poetry and venv
COPY --from=builder $POETRY_HOME $POETRY_HOME
COPY --from=builder $PYDEPS_PATH $PYDEPS_PATH

RUN poetry install --only dev

COPY . /app
WORKDIR /app
CMD ["python"]


# Prod image
FROM builder AS prod

# Copy in poetry and venv
COPY --from=builder $POETRY_HOME $POETRY_HOME
COPY --from=builder $PYDEPS_PATH $PYDEPS_PATH

COPY . /app
WORKDIR /app
CMD [ "python"]