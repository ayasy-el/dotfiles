#!/usr/bin/env bash
# Stow semua paket dotfile ke $HOME.
# Pakai: ./install.sh            -> stow semua paket
#        ./install.sh nvim zed   -> stow paket tertentu
set -euo pipefail

cd "$(dirname "$0")"

packages=("$@")
if [ ${#packages[@]} -eq 0 ]; then
  mapfile -t packages < <(find . -maxdepth 1 -mindepth 1 -type d -not -name '.*' -printf '%f\n' | sort)
fi

for pkg in "${packages[@]}"; do
  [ -d "$pkg" ] || { echo "skip: $pkg (bukan folder paket)"; continue; }
  echo "==> stow $pkg"
  stow --restow --target="$HOME" "$pkg"
done

echo "selesai."
