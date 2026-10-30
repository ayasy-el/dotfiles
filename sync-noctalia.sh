#!/usr/bin/env bash
# Sinkronisasi settings + wallpaper Noctalia (tidak di-stow karena hidup di
# XDG_STATE_HOME dan ditulis ulang oleh aplikasi).
#
#   ./sync-noctalia.sh save   -> simpan settings + wallpaper live ke repo
#   ./sync-noctalia.sh load   -> terapkan settings repo ke live + reload
#   ./sync-noctalia.sh diff   -> lihat beda settings
set -euo pipefail
shopt -s nullglob

ROOT="$(cd "$(dirname "$0")" && pwd)"
LIVE="$HOME/.local/state/noctalia-kwe/settings.toml"
REPO="$ROOT/_noctalia/settings.toml"
WL_DIR="$HOME/Pictures/Wallpapers"
WL_REPO="$ROOT/_noctalia/wallpapers"

# ambil semua path wallpaper yang dipakai settings
wallpaper_paths() {
  grep -oE '^path = ".*"' "$1" | cut -d'"' -f2 | sort -u
}

case "${1:-diff}" in
  save)
    cp "$LIVE" "$REPO"
    mkdir -p "$WL_REPO"
    while IFS= read -r p; do
      [ -f "$p" ] || { echo "lewati (tidak ada): $p"; continue; }
      cp "$p" "$WL_REPO/"
      echo "wallpaper: $p"
    done < <(wallpaper_paths "$LIVE")
    echo "disimpan: $LIVE -> $REPO"
    ;;
  load)
    mkdir -p "$WL_DIR"
    for f in "$WL_REPO"/*; do
      [ -e "$WL_DIR/$(basename "$f")" ] || cp "$f" "$WL_DIR/"
    done
    cp "$REPO" "$LIVE"
    echo "diterapkan: $REPO -> $LIVE"
    noctalia-kwe msg config-reload >/dev/null 2>&1 || echo "catatan: config-reload gagal, restart noctalia-kwe manual"
    ;;
  diff)
    diff -u "$REPO" "$LIVE" && echo "sama"
    ;;
  *)
    echo "pakai: $0 [save|load|diff]" >&2
    exit 1
    ;;
esac
