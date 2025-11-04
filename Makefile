	# ============================================
# Arch Bootstrap Project - Makefile
# ============================================
# Usage:
#   make <target>
# --------------------------------------------
# --- Auto-load environment from .env if present ---
-include .env
export $(shell sed 's/=.*//' .env 2>/dev/null)

# Default environment variables (override in your shell or .env)
BOOTSTRAP_USER ?= youruser
BOOTSTRAP_GITHUB_USER ?= yourgithubusername

# Default Python runner (uses uv if available)
PYTHON_RUN := uv run python

# --------------------------------------------
# Help Section
# --------------------------------------------
.PHONY: help
help:
	@echo ""
	@echo "Arch Bootstrap Makefile"
	@echo "========================"
	@echo ""
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?##' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "Environment:"
	@echo "  BOOTSTRAP_USER=$(BOOTSTRAP_USER)"
	@echo "  BOOTSTRAP_GITHUB_USER=$(BOOTSTRAP_GITHUB_USER)"
	@echo ""

# --------------------------------------------
# Targets
# --------------------------------------------
.PHONY: show-config
show-config: ## Print resolved configuration variables
	@echo "Running config summary with:"
	@echo "  BOOTSTRAP_USER=$(BOOTSTRAP_USER)"
	@echo "  BOOTSTRAP_GITHUB_USER=$(BOOTSTRAP_GITHUB_USER)"
	@$(PYTHON_RUN) -c "from arch_bootstrap import config; print(config.debug_summary())"

.PHONY: setup-env
setup-env: ## Run interactive environment setup script
	@uv run python tools/env_setup.py

.PHONY: test-make
test-make: ## make test-make  → Run tests that validate Makefile targets and mocks
	@echo "🧪 Running Makefile target tests..."
	@if [ -d .venv ]; then \
		. .venv/bin/activate; \
	else \
		echo "⚙️  Creating virtual environment with uv"; \
		uv sync --all-groups; \
		. .venv/bin/activate; \
	fi; \
	uv run pytest -v tests/test_make_targets.py

.PHONY: test
test: ## Run the pytest suite
	@echo "Running test suite..."
	@uv run pytest -v

.PHONY: smoke
smoke: ## Run only smoke tests
	@echo "Running smoke tests..."
	@uv run pytest -v -m smoke

.PHONY: lint
lint: ## Run formatters and static analysis
	@echo "Running Ruff, Black, and Mypy..."
	@uv run ruff check .
	@uv run black --check .
	@uv run mypy arch_bootstrap/

.PHONY: incus-run
incus-run: ## Execute the bootstrap script inside the Incus test container
	@echo "🧱 Running inside Incus container 'public-dots-test'..."
	incus exec public-dots-test -- bash -lc "cd /root/public-dots && make run"

.PHONY: run
run: ## Run the main bootstrap script (loads .env and uses .venv)
	@echo "🚀 Running main bootstrap script..."
	@if [ -f .env ]; then \
		echo "🔧 Loading environment from .env"; \
		set -a; source .env; set +a; \
	fi; \
	if [ -d .venv ]; then \
		echo "🐍 Using existing virtual environment"; \
		. .venv/bin/activate; \
	else \
		echo "⚙️  Creating virtual environment with uv"; \
		uv sync --all-groups; \
		. .venv/bin/activate; \
	fi; \
	python arch_bootstrap/main.py

.PHONY: clean
clean: ## Remove cache and temporary files
	@echo "Cleaning up temp files..."
	@find . -type d -name "__pycache__" -exec rm -rf {} +
	@rm -rf .pytest_cache .coverage

# --------------------------------------------
# Default target (runs help)
# --------------------------------------------
.DEFAULT_GOAL := help

