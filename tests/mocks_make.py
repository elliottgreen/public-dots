# tests/mocks_make.py
import subprocess


def fake_subprocess_run(cmd, *a, **kw):
    """Mock subprocess.run for Makefile-related targets."""
    class Result:
        def __init__(self):
            self.returncode = 0
            self.stdout = f"mocked run: {' '.join(cmd)}\n"
            self.stderr = ""
    return Result()


def fake_incus_exec(cmd, *a, **kw):
    """Mock incus exec command."""
    if "incus" in cmd:
        return type("R", (), {"returncode": 0, "stdout": "mocked incus\n", "stderr": ""})
    return fake_subprocess_run(cmd, *a, **kw)

