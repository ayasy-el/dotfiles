#!/usr/bin/env bash
# Sinkronisasi settings Noctalia (tidak di-stow karena hidup di XDG_STATE_HOME
# dan ditulis ulang oleh aplikasi).
#
#   ./sync-noctalia.sh save   -> simpan settings live ke repo
#   ./sync-noctalia.sh load   -> terapkan settings repo ke live + reload
#   ./sync-noctalia.sh diff   -> lihat bedanya
set -euo pipefail

LIVE="$HOME/.local/state/noctalia-kwe/settings.toml"
REPO="$(cd "$(dirname "$0")" && pwd)/_noctalia/settings.toml"

case "${1:-diff}" in
  save)
    cp "$LIVE" "$REPO"
    echo "disimpan: $LIVE -> $REPO"
    ;;
  load)
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
