#!/bin/sh
set -euo pipefail

SCRIPT_NAME=$(basename "$0")

. "$(dirname "$0")/globals-definitions"
. "$(dirname "$0")/util-log"

log_message $SCRIPT_NAME "Iniciando configuración de estructura de directorios"

debug_message $SCRIPT_NAME  "Creando directorios base de dependencias"
mkdir -p "$TARGET_DISK_DIR/tmp"
mkdir -p "$TARGET_DISK_DIR/sbin"
mkdir -p "$TARGET_DISK_DIR/lib/apk/db"
mkdir -p "$TARGET_DISK_DIR/etc/apk"
mkdir -p "$TARGET_DISK_DIR/etc/ssl/certs"
mkdir -p "$TARGET_DISK_DIR/usr/lib"

debug_message $SCRIPT_NAME "Creando directorios base de WolfbearOS"
mkdir -p "$TARGET_DISK_DIR/players"
mkdir -p "$TARGET_DISK_DIR/players/cheese"
mkdir -p "$TARGET_DISK_DIR/saves"
mkdir -p "$TARGET_DISK_DIR/apps"
mkdir -p "$TARGET_DISK_DIR/games"
mkdir -p "$TARGET_DISK_DIR/config"

log_message $SCRIPT_NAME "Configuración estructura de directorios terminada"
