# arch_bootstrap/repo.py
"""
Clone or update the dotfiles repository.

This module ensures the user's dotfiles repository exists locally and is updated.
It also configures Git to use tracked repository hooks from `.githooks` when that
directory exists.
"""

from pathlib import Path

from . import config
from .utils import log, run


def configure_tracked_hooks(repo_dir: Path) -> None:
    """
    Configure this repository to use tracked Git hooks.

    Git does not track `.git/hooks`, so the repository should store hooks in a
    normal tracked directory such as `.githooks`. This function sets the local
    Git config value:

        core.hooksPath = .githooks

    This is intentionally local to each clone.
    """
    hooks_dir = repo_dir / ".githooks"

    if not hooks_dir.exists():
        log("No .githooks directory found, skipping tracked hook setup.")
        return

    if not hooks_dir.is_dir():
        log(".githooks exists but is not a directory, skipping tracked hook setup.")
        return

    log("Configuring repository to use tracked hooks from .githooks.")
    run(
        [
            "git",
            "-C",
            str(repo_dir),
            "config",
            "core.hooksPath",
            ".githooks",
        ]
    )


def ensure_repo() -> None:
    """
    Clone or update the dotfiles repository, then configure tracked hooks.

    The repository path and URL are resolved from arch_bootstrap.config.
    """
    repo_dir = config.get_repo_dir()
    repo_url = config.get_repo_url()

    if not repo_dir.exists():
        log(f"Cloning repository from {repo_url}")
        run(["git", "clone", repo_url, str(repo_dir)])
    elif not (repo_dir / ".git").exists():
        raise RuntimeError(
            f"Repository path exists but is not a Git repository: {repo_dir}"
        )
    else:
        log("Repository already present, pulling latest changes.")
        run(["git", "-C", str(repo_dir), "pull"])

    configure_tracked_hooks(repo_dir)


if __name__ == "__main__":
    ensure_repo()
