#!/usr/bin/env bash
# Apex — Ubuntu installer
# Downloads the latest Apex .deb from GitHub Releases and installs it.
REPO="HeshamZegoo/apex"
# ----------------------------------------------------------------

set -e

API="https://api.github.com/repos/${REPO}/releases/latest"
TMP_DIR="$(mktemp -d)"
cd "$TMP_DIR"

# The combined release also ships a MIRA .deb, so select the Apex package
# specifically: the asset whose name matches Apex-*-ubuntu.deb.
DEB_URL="$(curl -fsSL "$API" \
  | grep -o '"browser_download_url": *"[^"]*"' \
  | grep -o 'https://[^"]*' \
  | grep -E '/Apex-[^/]*-ubuntu\.deb$' \
  | head -n 1 || true)"

if [ -n "$DEB_URL" ]; then
  echo "Downloading Apex from ${DEB_URL} ..."
  if curl -fL -o apex.deb "$DEB_URL"; then
    echo "Installing Apex (.deb) ..."
    sudo apt install -y ./apex.deb
    echo "Done! Run Apex from your apps menu, or type: apex-desktop"
    exit 0
  fi
fi

echo "Could not download the .deb — falling back to the AppImage version."

APPIMAGE_URL="$(curl -fsSL "$API" \
  | grep -o '"browser_download_url": *"[^"]*"' \
  | grep -o 'https://[^"]*' \
  | grep -E '/Apex-[^/]*\.AppImage$' \
  | head -n 1 || true)"
mkdir -p "$HOME/Applications"
curl -fL -o "$HOME/Applications/Apex.AppImage" "$APPIMAGE_URL"
chmod +x "$HOME/Applications/Apex.AppImage"
echo "AppImage saved to $HOME/Applications/Apex.AppImage"
echo "Run it with:  $HOME/Applications/Apex.AppImage"
