#!/bin/sh
set -euo pipefail

SCRIPT_NAME=$(basename "$0")

. "$(dirname "$0")/globals-definitions"
. "$(dirname "$0")/util-log"

log_message $SCRIPT_NAME "Montando particiones del kernel /proc /sys y /dev en $TARGET_DISK_DIR"

mount -t proc proc $TARGET_DISK_DIR/proc
mount --rbind /sys $TARGET_DISK_DIR/sys
mount --rbind /dev $TARGET_DISK_DIR/dev

log_message $SCRIPT_NAME "Particiones del kernel montadas exitosamente"
