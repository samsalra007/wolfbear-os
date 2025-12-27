#!/bin/sh
set -euo pipefail

SCRIPT_NAME=$(basename "$0")

log_message $SCRIPT_NAME "Iniciando limpieza final"

debug_message $SCRIPT_NAME "Desmontando particiones"

# umount -l "$TARGET_DISK_DIR/dev"
# umount -l "$TARGET_DISK_DIR/sys"
# umount -l "$TARGET_DISK_DIR/proc"

log_message $SCRIPT_NAME "Limpieza final terminada"
