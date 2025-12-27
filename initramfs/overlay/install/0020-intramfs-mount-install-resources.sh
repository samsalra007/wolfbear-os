#!/bin/sh
set -euo pipefail

SCRIPT_NAME=$(basename "$0")

log_message "$SCRIPT_NAME" "Iniciando script para montar recursos de instalación"

ensure_dir $INSTALL_RESOURCES_DIR

debug_message "$SCRIPT_NAME" "Buscando del disco de instalación"

if mountpoint -q $INSTALL_RESOURCES_DIR; then
  debug_message "$SCRIPT_NAME" "Ya estaba montado $INSTALL_RESOURCES_DIR"
else
  mount $INSTALL_RESOURCES_PARTITION $INSTALL_RESOURCES_DIR || debug_message "$SCRIPT_NAME" "No se pudo montar partición RESOURCES_PART_DIR"
fi

log_message "$SCRIPT_NAME" "Particiones de recursos de instalación montadas exitosamente"