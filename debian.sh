#!/bin/bash
set -e

BIN_DIR="/etc/wheeup/bin"
SYMLINK="/usr/bin/wheeup"
BINARY_URL="https://github.com/WheeLang/wheeup/releases/latest/download/wheeup"

# Check for root
if [[ $EUID -ne 0 ]]; then
  echo "Please run as root (e.g. sudo $0)"
  exit 1
fi

echo "Updating package lists..."
apt-get update -qq

echo "Installing dependencies..."
apt-get install -y curl libyaml-cpp0.8

echo "Creating directory $BIN_DIR ..."
mkdir -p "$BIN_DIR"

echo "Downloading wheeup binary..."
curl -L --fail "$BINARY_URL" -o "$BIN_DIR/wheeup"
chmod +x "$BIN_DIR/wheeup"

echo "Creating symlink $SYMLINK -> $BIN_DIR/wheeup ..."
ln -sf "$BIN_DIR/wheeup" "$SYMLINK"

echo "Installation complete! You can now run 'wheeup' from anywhere."
