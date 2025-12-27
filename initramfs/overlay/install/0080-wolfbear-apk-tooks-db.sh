#!/bin/sh
set -euo pipefail

SCRIPT_NAME=$(basename "$0")

log_message $SCRIPT_NAME "Iniciando configuración de base de datos apk tools"

# Copiar DNS para resolución
debug_message "$SCRIPT_NAME" "Copiando resolv.conf"
cp /etc/resolv.conf "$TARGET_DISK_DIR/etc/"
chmod 644 "$TARGET_DISK_DIR/etc/resolv.conf"

# Crear estructura básica para apk
debug_message "$SCRIPT_NAME" "Inicializando base de datos de apk-tools"
ensure_dir "$TARGET_DISK_DIR/var/lib/apk/db"
touch "$TARGET_DISK_DIR/var/lib/apk/db/installed"
chmod 644 "$TARGET_DISK_DIR/var/lib/apk/db/installed"

ensure_dir "$TARGET_DISK_DIR/etc/apk"
touch "$TARGET_DISK_DIR/etc/apk/world"
chmod 644 "$TARGET_DISK_DIR/etc/apk/world"

# Llaves
debug_message "$SCRIPT_NAME" "Copiando llaves de apk-tools"
ensure_dir "$TARGET_DISK_DIR/etc/apk/keys"
cp /etc/apk/keys/* "$TARGET_DISK_DIR/etc/apk/keys"

# Update
debug_message "$SCRIPT_NAME" "Actualizando índices de paquetes"
apk update --root "$TARGET_DISK_DIR"

log_message $SCRIPT_NAME "Configuración de base de datos apk-tools terminada"