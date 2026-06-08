# =============================================
# Arch Bootstrap Justfile
# =============================================

set dotenv-load

python := env_var_or_default("PYTHON", "python3")
module := "arch_bootstrap"

bootstrap_user := env_var_or_default("BOOTSTRAP_USER", `whoami`)
bootstrap_github_user := env_var_or_default("BOOTSTRAP_GITHUB_USER", bootstrap_user)
bootstrap_repo_url := env_var_or_default("BOOTSTRAP_REPO_URL", "https://github.com/" + bootstrap_user + "/public-dots.git")

# =============================================
# Default recipe
# =============================================

default:
    @just --list

# =============================================
# Main Recipes
# =============================================

# Run full Arch bootstrap process: user, packages, repo, dotfiles
run:
    @echo "==> Running Arch Bootstrap as {{ bootstrap_user }}"
    sudo \
      BOOTSTRAP_USER="{{ bootstrap_user }}" \
      BOOTSTRAP_GITHUB_USER="{{ bootstrap_github_user }}" \
      BOOTSTRAP_REPO_URL="{{ bootstrap_repo_url }}" \
      {{ python }} -m {{ module }}.main

# Run full test suite
test:
    @echo "==> Running all tests..."
    pytest -v tests

# Run smoke tests only
smoke:
    @echo "==> Running smoke tests..."
    pytest -m smoke -v

# Run lint checks using ruff
lint:
    @echo "==> Running linter..."
    ruff check {{ module }} tests

# Remove build and cache artifacts
clean:
    @echo "==> Cleaning up..."
    rm -rf __pycache__ */__pycache__ .pytest_cache .ruff_cache *.egg-info build dist

# Run interactive environment setup script
setup-env:
    @command -v uv >/dev/null 2>&1 || { echo "Error: uv not found in PATH"; exit 1; }
    @echo "==> Launching environment setup..."
    uv run python tools/env_setup.py

# Run bootstrap inside an Incus container
incus-run:
    @echo "==> Running inside Incus container..."
    incus exec mycontainer -- {{ python }} -m {{ module }}.main

# Show this help message
help:
    @just --list
