define composer
	${DOCKER_COMPOSE} run --rm $2 composer composer $1
endef

define docker-logs
	$(DOCKER) logs -f -t `cat ./dc.services | grep $1`
endef

define restart-docker
	$(DOCKER_COMPOSE) restart $1
endef

define up-docker
	$(DOCKER_COMPOSE) pull $1
	$(DOCKER_COMPOSE) up --build --remove-orphans -d $1
endef

define down-docker
	$(DOCKER_COMPOSE) down --remove-orphans
endef

define start-docker
	$(DOCKER_COMPOSE) start $1
endef

define stop-docker
	$(DOCKER_COMPOSE) stop $1
endef
