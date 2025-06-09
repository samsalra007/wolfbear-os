#!/bin/sh
set -euo pipefail

SCRIPT_NAME=$(basename "$0")

. "$(dirname "$0")/globals-definitions"
. "$(dirname "$0")/util-log"

log_message "$SCRIPT_NAME" "Iniciando script $SCRIPT_NAME"

log_message "$SCRIPT_NAME" "Creando estructura base en $TARGET_DISK_DIR"

ensure_dir "$TARGET_DISK_DIR"/{bin,etc,lib,proc,sys,usr,var,dev,run,tmp,mnt,home,root}
chmod 1777 "$TARGET_DISK_DIR/tmp"
