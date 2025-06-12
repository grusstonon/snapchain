.PHONY: build dev clean changelog

## Build all docker images
build:
	docker compose build

## Start development environment (rebuilds first)
dev: build
	docker compose up --watch

## Clean up Docker and Rust artifacts
clean:
	docker compose down --remove-orphans --volumes --rmi=all
	cargo clean

## Generate changelog for current SNAPCHAIN_VERSION from Cargo.toml
changelog:
	@SNAPCHAIN_VERSION=$$(awk -F '"' '/^version =/ {print $$2}' ./Cargo.toml) && \
	echo "Generating changelog for version: $$SNAPCHAIN_VERSION" && \
	git cliff --unreleased --tag "$$SNAPCHAIN_VERSION" --prepend CHANGELOG.md
