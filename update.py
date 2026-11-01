#!/usr/bin/env python3
import os
import socket
import subprocess
import sys
from datetime import datetime
from pathlib import Path

FLAKE_DIR = Path.home() / "nixos-config"
HOSTNAME = socket.gethostname()
FLAKE_TARGET = f"{FLAKE_DIR}#{HOSTNAME}"
LOG_FILE = Path("/tmp/nixos-dry-build.log")


def run(cmd, **kwargs):
    return subprocess.run(cmd, check=True, **kwargs)


def update_yazi_hash():
    """Fetch latest catppuccin/yazi revision and sha256, then update home/modules/yazi.nix"""
    import re

    yazi_path = os.path.join(FLAKE_DIR, "home", "modules", "yazi.nix")
    print("Updating yazi.nix with latest rev and sha256...")
    # Use nix-prefetch-git to get rev and sha256
    result = subprocess.run(
        ["nix-prefetch-git", "https://github.com/catppuccin/yazi"],
        capture_output=True,
        text=True,
        check=True,
    )
    rev = None
    sha256 = None
    for line in result.stdout.splitlines():
        if line.startswith("rev ="):
            rev = line.split("=")[1].strip().strip('"')
        elif line.startswith("sha256 ="):
            sha256 = line.split("=")[1].strip().strip('"')
    if not rev or not sha256:
        raise RuntimeError("Failed to obtain rev/sha256 from nix-prefetch-git")
    # Read file
    content = yazi_path.read_text()
    # Replace rev and sha256 within fetchFromGitHub block
    content = re.sub('rev = "[^"]*"', f'rev = "{rev}"', content)
    content = re.sub('sha256 = "[^"]*"', f'sha256 = "{sha256}"', content)
    yazi_path.write_text(content)
    print(f"Updated yazi.nix to rev {rev} and sha256 {sha256}")


def main():
    # Update yazi.nix before flake update
    try:
        update_yazi_hash()
    except Exception as e:
        print(f"Warning: could not update yazi.nix: {e}")
        # continue anyway
    run(["nix", "flake", "update", "--flake", str(FLAKE_DIR)])

    print("Simpan Commit terlebih dahulu")
    # Check for git changes
    result = subprocess.run(["git", "diff", "--quiet"], cwd=FLAKE_DIR, check=False)
    if result.returncode != 0:
        run(["git", "add", "."], cwd=FLAKE_DIR)
        commit_msg = f"update tanggal {datetime.now().strftime('%a %b %d %H:%M:%S %Y')}"
        run(["git", "commit", "-m", commit_msg], cwd=FLAKE_DIR)
    else:
        print("Tidak ada perubahan, skip commit")

    print("DRY BUILD")
    result = subprocess.run(
        ["nixos-rebuild", "dry-build", "--flake", FLAKE_TARGET],
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
    )
    LOG_FILE.write_text(result.stdout)
    print(result.stdout)

    run(["less", str(LOG_FILE)])

    if result.returncode != 0:
        print(f"Dry build gagal (exit code {result.returncode}); update dibatalkan.")
        sys.exit(result.returncode)

    auto_confirm = (
        os.getenv("UPDATE_AUTO_CONFIRM", "").lower() == "y"
        or "--yes" in sys.argv
        or "-y" in sys.argv
    )
    if auto_confirm:
        answer = "y"
    else:
        answer = input("Mau lanjut update? (y/n) ")
    if answer != "y":
        print("Oke update dibatalkan")
        sys.exit(130)

    print("Catat Generasi Sekarang")
    old_gen = get_current_generation(FLAKE_TARGET)

    print("Memulai Update")
    run(["time", "sudo", "nixos-rebuild", "switch", "--flake", FLAKE_TARGET])

    print("Catat Generasi Sekarang")
    new_gen = get_current_generation(FLAKE_TARGET)

    print("Perbandingan")
    run(
        [
            "nvd",
            "diff",
            f"/nix/var/nix/profiles/system-{old_gen}-link",
            f"/nix/var/nix/profiles/system-{new_gen}-link",
        ]
    )


def get_current_generation(flake_target: str) -> str:
    result = subprocess.run(
        ["nixos-rebuild", "list-generations", "--flake", flake_target],
        capture_output=True,
        text=True,
        check=True,
    )
    for line in result.stdout.splitlines():
        columns = line.split()
        if columns and columns[-1] == "True":
            return columns[0]
    raise RuntimeError("Gak ketemu generasi yang aktif")


if __name__ == "__main__":
    main()
