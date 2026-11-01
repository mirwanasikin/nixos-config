#!/usr/bin/env python3
import gzip
import lzma
import os
import re
import socket
import subprocess
import sys
import time
import urllib.error
import urllib.request
from datetime import datetime
from pathlib import Path

FLAKE_DIR = Path.home() / "nixos-config"
MODULES_DIR = FLAKE_DIR / "home" / "modules"
HOSTNAME = socket.gethostname()
FLAKE_TARGET = f"{FLAKE_DIR}#{HOSTNAME}"
LOG_FILE = Path("/tmp/nixos-dry-build.log")

YAZI_REPO = "https://github.com/catppuccin/yazi"

# Repo apt resmi Claude Desktop (Linux beta)
CLAUDE_APT_BASE = "https://downloads.claude.ai/claude-desktop/apt/stable"
CLAUDE_APT_INDEXES = [
    "dists/stable/main/binary-amd64/Packages.xz",
    "dists/stable/main/binary-amd64/Packages.gz",
    "dists/stable/main/binary-amd64/Packages",
]


def run(cmd, **kwargs):
    return subprocess.run(cmd, check=True, **kwargs)


def capture(cmd, **kwargs) -> str:
    return run(cmd, capture_output=True, text=True, **kwargs).stdout.strip()


# ---------------------------------------------------------------------------
# Helper buat edit file .nix
# ---------------------------------------------------------------------------


def to_sri(digest: str) -> str:
    """Ubah sha256 (hex atau base32) jadi format SRI: sha256-xxxx="""
    return capture(
        ["nix", "hash", "convert", "--hash-algo", "sha256", "--to", "sri", digest]
    )


def set_nix_attr(content: str, attr: str, value: str) -> str:
    """Ganti `attr = "..."; ` di file nix. Harus ketemu tepat 1 kali."""
    pattern = re.compile(rf'^(\s*){attr}(\s*=\s*)"[^"]*";', re.M)
    new, count = pattern.subn(
        lambda m: f'{m.group(1)}{attr}{m.group(2)}"{value}";', content
    )
    if count != 1:
        raise RuntimeError(f"`{attr}` ketemu {count}x, harusnya tepat 1x")
    return new


def set_nix_hash(content: str, sri: str) -> str:
    """Set `hash = "sha256-..."`. Kalau masih pakai `sha256 = "..."`, diganti jadi `hash`."""
    if re.search(r"^\s*hash\s*=", content, re.M):
        return set_nix_attr(content, "hash", sri)
    pattern = re.compile(r'^(\s*)sha256(\s*=\s*)"[^"]*";', re.M)
    new, count = pattern.subn(
        lambda m: f'{m.group(1)}hash{m.group(2)}"{sri}";', content
    )
    if count != 1:
        raise RuntimeError(f"`sha256`/`hash` ketemu {count}x, harusnya tepat 1x")
    return new


# ---------------------------------------------------------------------------
# yazi.nix  (catppuccin/yazi)
# ---------------------------------------------------------------------------


def update_yazi() -> None:
    """Ambil commit terbaru catppuccin/yazi lalu update rev + hash di home/modules/yazi.nix"""
    path = MODULES_DIR / "yazi.nix"
    print("Cek catppuccin/yazi...")

    rev = capture(["git", "ls-remote", YAZI_REPO, "HEAD"]).split()[0]
    old = path.read_text()
    if f'"{rev}"' in old:
        print(f"yazi.nix sudah paling baru ({rev[:7]})")
        return

    # --unpack = hash yang sama persis dengan yang dihitung fetchFromGitHub
    base32 = capture(
        [
            "nix-prefetch-url",
            "--unpack",
            "--type",
            "sha256",
            f"{YAZI_REPO}/archive/{rev}.tar.gz",
        ]
    ).splitlines()[-1]

    new = set_nix_hash(set_nix_attr(old, "rev", rev), to_sri(base32))
    path.write_text(new)
    print(f"yazi.nix -> {rev[:7]}")


# ---------------------------------------------------------------------------
# claude.nix  (Claude Desktop, .deb dari apt repo resmi)
# ---------------------------------------------------------------------------


def fetch_apt_index() -> str:
    errors = []
    for rel in CLAUDE_APT_INDEXES:
        url = f"{CLAUDE_APT_BASE}/{rel}"
        try:
            with urllib.request.urlopen(url, timeout=30) as resp:
                raw = resp.read()
        except (urllib.error.URLError, TimeoutError) as e:
            errors.append(f"{rel}: {e}")
            continue
        if rel.endswith(".xz"):
            raw = lzma.decompress(raw)
        elif rel.endswith(".gz"):
            raw = gzip.decompress(raw)
        return raw.decode()
    raise RuntimeError("index apt Claude gak bisa diambil:\n  " + "\n  ".join(errors))


def parse_packages(text: str) -> list[dict[str, str]]:
    """Parse file `Packages` (format deb822) jadi list dict per paket."""
    entries = []
    for block in text.strip().split("\n\n"):
        fields = {}
        for line in block.splitlines():
            if line[:1] in (" ", "\t") or ":" not in line:
                continue  # baris lanjutan / sampah
            key, value = line.split(":", 1)
            fields[key.strip()] = value.strip()
        if fields:
            entries.append(fields)
    return entries


def version_key(version: str) -> tuple[int, ...]:
    return tuple(int(x) for x in re.findall(r"\d+", version))


def latest_claude(entries: list[dict[str, str]]) -> dict[str, str]:
    candidates = [e for e in entries if e.get("Package") == "claude-desktop"]
    if not candidates:
        raise RuntimeError("paket claude-desktop gak ada di index apt")
    best = max(candidates, key=lambda e: version_key(e["Version"]))
    for field in ("Version", "Filename", "SHA256"):
        if field not in best:
            raise RuntimeError(f"field `{field}` gak ada di entry apt")
    return best


def update_claude() -> None:
    """Cek versi terbaru Claude Desktop di apt resmi lalu update version, url, hash di claude.nix"""
    path = MODULES_DIR / "claude.nix"
    print("Cek Claude Desktop di apt repo...")

    entry = latest_claude(parse_packages(fetch_apt_index()))
    version = entry["Version"]
    url = f"{CLAUDE_APT_BASE}/{entry['Filename']}"
    sri = to_sri(entry["SHA256"])

    old = path.read_text()
    new = set_nix_hash(
        set_nix_attr(set_nix_attr(old, "version", version), "url", url), sri
    )
    if new == old:
        print(f"claude.nix sudah paling baru ({version})")
        return
    path.write_text(new)
    print(f"claude.nix -> {version}")


def update_pins() -> None:
    """Update semua versi/hash yang di-pin manual. Gagal 1 gak ngebatalin yang lain."""
    for name, fn in (("yazi.nix", update_yazi), ("claude.nix", update_claude)):
        try:
            fn()
        except Exception as e:
            print(f"Warning: gagal update {name}: {e}", file=sys.stderr)


# ---------------------------------------------------------------------------
# Alur update utama
# ---------------------------------------------------------------------------


def main():
    update_pins()
    if "--pins-only" in sys.argv:
        return

    run(["nix", "flake", "update", "--flake", str(FLAKE_DIR)])

    print("Simpan Commit terlebih dahulu")
    # status --porcelain juga nangkep file baru (untracked), beda dengan `git diff --quiet`
    dirty = capture(["git", "status", "--porcelain"], cwd=FLAKE_DIR)
    if dirty:
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
    start = time.monotonic()
    run(["sudo", "nixos-rebuild", "switch", "--flake", FLAKE_TARGET])
    print(f"Selesai dalam {time.monotonic() - start:.0f} detik")

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
