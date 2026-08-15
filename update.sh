#!/usr/bin/env bash

set -euo pipefail

FLAKE_DIR="$HOME/nixos-config"
HOSTNAME="$(hostname)"
FLAKE_TARGET="${FLAKE_DIR}#${HOSTNAME}"

nix flake update --flake "$FLAKE_DIR"

echo "Simpan commit terlebih dahulu"
git add .
git commit -m "update tanggal $(date)"

echo "Dry Build"
nixos-rebuild dry-build --flake "$FLAKE_TARGET" 2>&1 | tee /tmp/nixos-dry-build.log

less /tmp/nixos-dry-build.log

read -p "Mau lanjut update?(y/n) " answer

if [[ "$answer" != "y" ]]; then
  echo "Oke dibatalkan"
  exit 1
fi

echo "Catat Generasi sekarang"
OLD_GEN=$(nixos-rebuild list-generations --flake "$FLAKE_TARGET" | awk '$NF=="True" {print $1}')

echo "Memulai Update"
sudo nixos-rebuild switch --flake "$FLAKE_TARGET"

echo "Catat generasi baru"
NEW_GEN=$(nixos-rebuild list-generations --flake "$FLAKE_TARGET" | awk '$NF=="True" {print $1}')

echo "Perbandingan"
nvd diff "/nix/var/nix/profiles/system-${OLD_GEN}-link" "/nix/var/nix/profiles/system-${NEW_GEN}-link"
