include .env

DRUSH ?= docker-compose exec php ../vendor/bin/drush

install:
	$(DRUSH) site-install idea \
		--local=en \
		--account-name=$(ACCOUNT_NAME) \
		--account-mail=$(ACCOUNT_EMAIL) \
		--account-pass=$(ACCOUNT_PASSWORD) \
		--db-url=mysql://$(DB_USER):$(DB_PASSWORD)@$(DB_HOST):3306/$(DB_NAME) \
		--site-name="$(SITE_NAME)" \
		install_configure_form.update_status_module='array(FALSE,FALSE)' \
		-vvv \
		-y && \
		$(DRUSH) cr

up:
	@echo "Starting up containers for $(PROJECT_NAME)..."
	docker-compose pull
	docker-compose up -d --remove-orphans