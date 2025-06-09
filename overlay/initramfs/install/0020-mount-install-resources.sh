#!/bin/sh
set -euo pipefail

SCRIPT_NAME=$(basename "$0")

. "$(dirname "$0")/globals-definitions"
. "$(dirname "$0")/util-log"

log_message "$SCRIPT_NAME" "Iniciando script $SCRIPT_NAME"

ensure_dir $INSTALL_RESOURCES_DIR

log_message "$SCRIPT_NAME" "Montando recursos del disco de instalación"

if mountpoint -q $INSTALL_RESOURCES_DIR; then
  log_message "$SCRIPT_NAME" "Ya estaba montado $INSTALL_RESOURCES_DIR"
else
  mount $INSTALL_RESOURCES_PARTITION $INSTALL_RESOURCES_DIR || log_message "$SCRIPT_NAME" "No se pudo montar partición RESOURCES_PART_DIR"
fi
