<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
# Table of Contents

- [Setup project](#setup-project)
  - [Preconditions](#preconditions)
  - [Setup](#setup)
    - [Run setup command](#run-setup-command)
    - [Configure environment variables](#configure-environment-variables)
    - [[Optional] Install XQuartz](#optional-install-xquartz)
      - [Step #1](#step-1)
      - [Step #2](#step-2)
- [Build project](#build-project)
  - [Prerequisites](#prerequisites)
    - [Setup XCode](#setup-xcode)
    - [Other dependencies](#other-dependencies)
  - [Build](#build)
    - [Step 1 - Build locally & open XCode](#step-1---build-locally--open-xcode)
    - [Step 2 - Setup & Run](#step-2---setup--run)
    - [Step 3 - Allow launching external developers' apps.](#step-3---allow-launching-external-developers-apps)
- [Future considerations & goals](#future-considerations--goals)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Setup project
## Preconditions
* Virtual env created and activated (e.g. [pyenv](https://github.com/pyenv/pyenv)).
## Setup
### Run setup command
It will install dependencies and create an `.env` file.
```shell
$ make setup
```
### Configure environment variables
Populate `src/.env` with expected values.

### [Optional] Install XQuartz
Note: skip it for now. XQuartz would be required for developing containerized desktop apps, which isn't supported as of today.

#### Step #1
```shell
$ brew install --cask xquartz
```
OR follow instructions from https://www.xquartz.org/

#### Step #2
Enable `Allow connections from network clients` in settings (XQuartz > Settings > Security).


# Build project
## Prerequisites
### Setup XCode
1. Install XCode from App Store (https://apps.apple.com/us/app/xcode/id497799835?mt=12).
2. Run `xcode-select --install`
3. Run `xcodebuild -runFirstLaunch`
4. Install an iPhone emulator (in XCode GUI).

### Other dependencies
Details: https://kivy.org/doc/stable/guide/packaging-ios.html#prerequisites
```shell
$ brew install autoconf automake libtool pkg-config
$ brew link libtool
```

## Build
### Step 1 - Build locally & open XCode
```shell
$ make build
$ make open
```
### Step 2 - Setup & Run
1. Plug in your iPhone.
2. Configure signing in `Signing & Capabilities`.
3. Select your device as a target.
4. Click Run (`>`).

[Troubleshooting](https://nrodrig1.medium.com/put-kivy-application-on-iphone-b9b4fd4692e9).

### Step 3 - Allow launching external developers' apps.
1. Go to `General > VPN & Device Management`.
2. Trust the app.


# Future considerations & goals
1. Develop with Docker (X11 forwarding with XQuartz).
2. Build with Buildozer.
3. Build with Docker (Docker-OSX).
