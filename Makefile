.DEFAULT_GOAL := help

PLAYWRIGHT_INSTALL_FLAGS :=
ifeq ($(shell uname -s),Linux)
PLAYWRIGHT_INSTALL_FLAGS := --with-deps
endif

.PHONY: help bootstrap deps playwright-install build test e2e run check lint format format-fix clean

help: ## Show available targets
	@printf "Available targets:\n"
	@awk 'BEGIN {FS = ":.*## "}; /^[a-zA-Z0-9_.-]+:.*## / {printf "  %-20s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

bootstrap: ## Install Homebrew and Bun dependencies
	brew bundle
	bun ci

deps: ## Install Bun dependencies from bun.lock
	bun ci

playwright-install: ## Install Playwright browsers and system dependencies
	bunx playwright install $(PLAYWRIGHT_INSTALL_FLAGS)

build: ## Build the production bundle
	bun build:prod

test: ## Run unit tests
	bun unittest

e2e: ## Run end-to-end tests
	bun test:e2e

run: ## Run the project
	@printf "No standalone run command is defined for this OpenCode plugin. Load index.ts from OpenCode instead.\n" >&2
	@exit 1

check: build ## Run non-destructive checks
	bun typecheck
	bun lint
	bun format

lint: ## Run lint checks
	bun lint

format: ## Check formatting
	bun format

format-fix: ## Format files in place
	bun format:fix

clean: ## Remove generated outputs
	bun clean
