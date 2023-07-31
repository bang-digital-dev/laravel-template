#######################################################################
# ⚠️🔥🚧 Warning! These commands are for local development only 🚧🔥⚠️
#######################################################################

# Variables
DOCKER_COMPOSE = docker-compose --file=./docker/local-dev/docker-compose.yml --env-file ./docker/local-dev/common.env --project-name myapp

# Build Docker images
build:
	@echo "Building docker images..."
	$(DOCKER_COMPOSE) build

# Start Docker containers
start:
	@echo "Starting docker containers..."
	$(DOCKER_COMPOSE) up -d
	@sleep 5

# Stop Docker containers
stop:
	@echo "Stopping docker containers..."
	$(DOCKER_COMPOSE) stop

# Remove Docker containers, volumes, and networks
remove:
	@echo "Removing docker containers, volumes, networks..."
	$(DOCKER_COMPOSE) down -v

# Initialize project
init:
	@echo "Installing composer packages..."
	@docker exec -it php-fpm composer install

	@echo "Creating public bucket in MinIO..."
	$(DOCKER_COMPOSE) run --rm --entrypoint=/usr/bin/create_bucket minio-mc

	@echo "Running database migrations..."
	@docker exec -it php-fpm php artisan migrate

	make admin

# Run PHP container's shell
php_sh:
	@echo "Running PHP container's shell..."
	@docker exec -it php-fpm sh

# Run seeders
seed:
	@echo "Running seeders..."
	@docker exec -it php-fpm php artisan db:seed

# Create Admin User
admin:
	@echo "Creating admin user..."
	@docker exec -it php-fpm php artisan create:admin John admin@mail.test 12345

# PHPStan
phpstan:
	@docker exec -it php-fpm ./vendor/bin/phpstan analyse --memory-limit=2G

# PHPStan
test:
	@docker exec -it php-fpm php artisan test
