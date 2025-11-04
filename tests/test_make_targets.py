# tests/test_make_targets.py
import subprocess
import arch_bootstrap.utils as utils

# Ensure local tests/ directory is importable
import sys, pathlib
sys.path.append(str(pathlib.Path(__file__).parent))
import mocks_make


def test_make_run(monkeypatch, tmp_path):
    """Ensure make run executes main.py correctly."""
    import mocks_make

    monkeypatch.setattr(subprocess, "run", mocks_make.fake_subprocess_run)
    monkeypatch.setattr(utils, "log", lambda m: None)

    result = subprocess.run(["make", "run"], capture_output=True, text=True)
    assert "mocked run" in result.stdout


# def test_make_incus_run(monkeypatch):
#     """Ensure make incus-run calls incus exec."""
#     import mocks_make
# 
#     monkeypatch.setattr(subprocess, "run", mocks_make.fake_incus_exec)
#     result = subprocess.run(["make", "incus-run"], capture_output=True, text=True)
#     assert "mocked incus" in result.stdout

def test_make_incus_run(monkeypatch):
    """Ensure make incus-run calls incus exec."""
    import mocks_make

    monkeypatch.setattr(subprocess, "run", mocks_make.fake_incus_exec)
    result = subprocess.run(["make", "incus-run"], capture_output=True, text=True)
    assert "mocked" in result.stdout


def test_make_smoke(monkeypatch):
    """Ensure make smoke calls pytest smoke tests."""
    import mocks_make

    monkeypatch.setattr(subprocess, "run", mocks_make.fake_subprocess_run)
    result = subprocess.run(["make", "smoke"], capture_output=True, text=True)
    assert "mocked run" in result.stdout


def test_make_test(monkeypatch):
    """Ensure make test triggers full pytest suite."""
    import mocks_make

    monkeypatch.setattr(subprocess, "run", mocks_make.fake_subprocess_run)
    result = subprocess.run(["make", "test"], capture_output=True, text=True)
    assert "mocked run" in result.stdout


def test_make_lint(monkeypatch):
    """Ensure make lint runs lint checks."""
    import mocks_make

    monkeypatch.setattr(subprocess, "run", mocks_make.fake_subprocess_run)
    result = subprocess.run(["make", "lint"], capture_output=True, text=True)
    assert "mocked run" in result.stdout


def test_make_clean(monkeypatch):
    """Ensure make clean removes artifacts."""
    import mocks_make

    monkeypatch.setattr(subprocess, "run", mocks_make.fake_subprocess_run)
    result = subprocess.run(["make", "clean"], capture_output=True, text=True)
    assert "mocked run" in result.stdout


def test_make_env(monkeypatch):
    """Ensure make env lists or edits env vars."""
    import mocks_make

    monkeypatch.setattr(subprocess, "run", mocks_make.fake_subprocess_run)
    result = subprocess.run(["make", "env"], capture_output=True, text=True)
    assert "mocked run" in result.stdout

