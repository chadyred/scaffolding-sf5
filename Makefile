ID ?= '$(shell which id)'
USER ?= $(shell $(ID) -un)
USER_ID ?= $(shell $(ID) -u)

DOCKER := '$(shell which docker)'
DOCKER_COMPOSE := '$(shell which docker-compose)'
PWD := $(shell which pwd)
APP_DIR ?= $(shell $(PWD))
COMPOSER_CACHE_DIRECTORY ?= $(HOME)/.composer
ENV ?= "development"

.DEFAULT_GOAL = help

install: .install ## Install all

.PHONY: dc-build
dc-build:
	$(call dc-build)

.install: dc-build vendor/autoload.php
	$(call dc-build)
	> $@

start: .env vendor/autoload.php ## Start project all
	$(call up-docker, database php-fpm nginx reverseproxy)

restart: .env vendor/autoload.php ## Restart project all
	$(call down-docker)
	$(call up-docker, database php-fpm nginx reverseproxy)

vendor/autoload.php/%: ## install compose dependency with % like a dependency(;version) and we can add args with OPTS, like `OPTS="--dev"`.
	$(call composer,require $*)

vendor/autoload.php: ## install whole dependencies
	$(call composer,install)

.env: ## Configure env
	cp .env.dev .env
	echo "USER_ID=$(USER_ID)" >> $@
	echo "USER=$(USER)" >> $@
	echo "COMPOSER_CACHE_DIRECTORY=$(COMPOSER_CACHE_DIRECTORY)" >> $@
	echo "APP_DIR=$(APP_DIR)" >> $@

vendor/autoload: .env ## Install dependencies
	$(DOCKER-COMPOSE) run --rm composer composer install

include make/helpers.mk
