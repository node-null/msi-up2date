#!/usr/bin/env bash

set -euo pipefail

BASE_DIR="/opt/zabbix"
TARGET_SCRIPTS_DIR="/opt/zabbix/scripts"
SOURCE_SCRIPTS_DIR="zabbix/scripts"

REQUIRED_DIRS=("configs" "common" "scripts")

log() {
  echo "[INFO] $1"
}

warn() {
  echo "[WARN] $1"
}

error() {
  echo "[ERROR] $1" >&2
  exit 1
}

check_root() {
  if [[ "$EUID" -ne 0 ]]; then
    error "Uruchom jako root (sudo)."
  fi
}

check_source() {
  if [[ ! -d "$SOURCE_SCRIPTS_DIR" ]]; then
    error "Brak katalogu źródłowego: $SOURCE_SCRIPTS_DIR"
  fi
}

create_base_dir() {
  if [[ ! -d "$BASE_DIR" ]]; then
    log "Tworzę katalog bazowy: $BASE_DIR"
    mkdir -p "$BASE_DIR"
  else
    log "Katalog bazowy istnieje: $BASE_DIR"
  fi
}

ensure_structure() {
  for dir in "${REQUIRED_DIRS[@]}"; do
    full_path="$BASE_DIR/$dir"

    if [[ -d "$full_path" ]]; then
      log "OK: $full_path istnieje"
    else
      warn "Brak katalogu: $full_path — tworzę"
      mkdir -p "$full_path"
    fi
  done
}

ensure_target_dir() {
  if [[ ! -d "$TARGET_SCRIPTS_DIR" ]]; then
    log "Tworzę katalog docelowy: $TARGET_SCRIPTS_DIR"
    mkdir -p "$TARGET_SCRIPTS_DIR"
  else
    log "Katalog docelowy istnieje: $TARGET_SCRIPTS_DIR"
  fi
}

copy_scripts() {
  log "Kopiuję skrypty z $SOURCE_SCRIPTS_DIR do $TARGET_SCRIPTS_DIR"

  # kopiuje zawartość katalogu (w tym pliki ukryte)
  cp -a "$SOURCE_SCRIPTS_DIR"/. "$TARGET_SCRIPTS_DIR"/
}}

set_permissions() {
  log "Ustawiam uprawnienia"

  chown -R root:root "$BASE_DIR" "$TARGET_SCRIPTS_DIR"
  chmod -R 755 "$BASE_DIR" "$TARGET_SCRIPTS_DIR"
}

main() {
  check_root
  check_source
  create_base_dir
  ensure_structure
  ensure_target_dir
  copy_scripts
  set_permissions

  log "Instalacja zakończona."
}

main "$@"
