#!/usr/bin/env bash
# Apex — Ubuntu installer
# Downloads the latest Apex .deb from GitHub Releases and installs it.
#
# >>> EDIT THIS: replace HeshamZegoo with the real GitHub owner/org <<<
REPO="HeshamZegoo/apex"
# ----------------------------------------------------------------

set -e

DEB_NAME="Apex-1.0.0-ubuntu.deb"
DEB_URL="https://github.com/${REPO}/releases/latest/download/${DEB_NAME}"
TMP_DIR="$(mktemp -d)"
cd "$TMP_DIR"

echo "Downloading Apex from ${DEB_URL} ..."
if curl -fL -o apex.deb "$DEB_URL"; then
  echo "Installing Apex (.deb) ..."
  sudo apt install -y ./apex.deb
  echo "Done! Run Apex from your apps menu, or type: apex-desktop"
  exit 0
fi

echo "Could not download the .deb — falling back to the AppImage version."

APPIMAGE_NAME="Apex-1.0.0.AppImage"
APPIMAGE_URL="https://github.com/${REPO}/releases/latest/download/${APPIMAGE_NAME}"
mkdir -p "$HOME/Applications"
curl -fL -o "$HOME/Applications/Apex.AppImage" "$APPIMAGE_URL"
chmod +x "$HOME/Applications/Apex.AppImage"
echo "AppImage saved to $HOME/Applications/Apex.AppImage"
echo "Run it with:  $HOME/Applications/Apex.AppImage"
