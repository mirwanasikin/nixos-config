#!/usr/bin/env bash
set -e

NIX_FILE="$HOME/nixos-config/home/modules/brave-origin.nix"
PACKAGES_URL="https://brave-browser-apt-nightly.s3.brave.com/dists/stable/main/binary-amd64/Packages"

PACKAGES=$(curl -s "$PACKAGES_URL")

LATEST_VERSION=$(echo "$PACKAGES" | awk '/^Package: brave-origin-nightly$/{found=1} found && /^Version:/{print $2; exit}')
LATEST_SHA256=$(echo "$PACKAGES" | awk '/^Package: brave-origin-nightly$/{found=1} found && /^SHA256:/{print $2; exit}')

CURRENT_VERSION=$(grep 'version = ' "$NIX_FILE" | grep -oP '[\d.]+')

if [ "$CURRENT_VERSION" = "$LATEST_VERSION" ]; then
  echo "✓ Already up to date: $CURRENT_VERSION"
  exit 0
fi

echo "Update found: $CURRENT_VERSION → $LATEST_VERSION"

# Convert SHA256 → SRI
LATEST_HASH="sha256-$(echo "$LATEST_SHA256" | xxd -r -p | base64 -w0)"

# Patch file
sed -i "s/version = \"$CURRENT_VERSION\"/version = \"$LATEST_VERSION\"/" "$NIX_FILE"
sed -i "s|hash = \"sha256-.*\"|hash = \"$LATEST_HASH\"|" "$NIX_FILE"

echo "✓ Updated to $LATEST_VERSION"
echo "  Hash: $LATEST_HASH"
