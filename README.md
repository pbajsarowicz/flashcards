<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
# Table of Contents

- [Project setup](#project-setup)
  - [Preconditions](#preconditions)
  - [Setup](#setup)
    - [Run setup command](#run-setup-command)
    - [Configure environment variables](#configure-environment-variables)
    - [Install XQuartz](#install-xquartz)
      - [Step #1](#step-1)
      - [Step #2](#step-2)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Project setup
## Preconditions
* Virtual env created and activated.
## Setup
### Run setup command
It will install dependencies and create an `.env` file.
```shell
$ make setup
```
### Configure environment variables
Populate `src/.env` with expected values.

### Install XQuartz
It's required for developing containerized desktop apps.

#### Step #1
```shell
$ brew install --cask xquartz
```
OR follow instructions from https://www.xquartz.org/

#### Step #2
Enable `Allow connections from network clients` in settings (XQuartz > Settings > Security).
