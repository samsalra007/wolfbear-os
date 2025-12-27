#!/bin/sh
set -euo pipefail

SCRIPT_NAME=$(basename "$0")

log_message $SCRIPT_NAME "Sincronizando capas de overlay en '$TARGET_DISK_DIR'"

debug_message $SCRIPT_NAME "Sincronizando capa de rootfs a '$TARGET_DISK_DIR'"
rsync -a --links "$INSTALL_RESOURCES_DIR/rootfs-overlay/" "$TARGET_DISK_DIR/"

debug_message $SCRIPT_NAME "Sincronizando capa de módulos a '$TARGET_DISK_DIR'"
rsync -a --links "$INSTALL_RESOURCES_DIR/modules-modprobe/" "$TARGET_DISK_DIR/"

debug_message $SCRIPT_NAME "Sincronizando capa de busybox a '$TARGET_DISK_DIR'"
rsync -a --links "$INSTALL_RESOURCES_DIR/busybox-compiled/" "$TARGET_DISK_DIR/"

debug_message $SCRIPT_NAME "Sincronizando capa de aplicaciones a '$TARGET_DISK_DIR'"
rsync -a --links "$INSTALL_RESOURCES_DIR/sys-apps/" "$TARGET_DISK_DIR/"

log_message $SCRIPT_NAME "Las capas overlay han sido sincronizadas exitosamente en '$TARGET_DISK_DIR'"
