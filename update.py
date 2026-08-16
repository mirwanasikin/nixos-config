import subprocess
import socket
import sys
from datetime import datetime
from pathlib import Path

FLAKE_DIR = Path.home() / "nixos-config"
HOSTNAME = socket.gethostname()
FLAKE_TARGET = f"{FLAKE_DIR}#{HOSTNAME}"
LOG_FILE = Path("/tmp/nixos-dry-build.log")


def run(cmd, **kwargs):
    return subprocess.run(cmd, check=True, **kwargs)


def main():
    run(["nix", "flake", "update", "--flake", str(FLAKE_DIR)])

    print("Simpan Commit terlebih dahulu")
    run(["git", "add", "."], cwd=FLAKE_DIR)
    commit_msg = f"update tanggal {datetime.now().strftime('%a %b %d %H:%M:%S %Y')}"
    run(["git", "commit", "-m", commit_msg], cwd=FLAKE_DIR)

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

    answer = input("Mau lanjut update? (y/n) ")
    if answer != "y":
        print("Oke update dibatalkan")
        sys.exit(1)

    print("Catat Generasi Sekarang")
    old_gen = get_current_generation(FLAKE_TARGET)

    print("Memulai Update")
    run(["sudo", "nixos-rebuild", "switch", "--flake", FLAKE_TARGET])

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
