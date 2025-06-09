#!/bin/sh
set -euo pipefail

SCRIPT_NAME=$(basename "$0")

. "$(dirname "$0")/globals-definitions"
. "$(dirname "$0")/util-log"

log_message "$SCRIPT_NAME" "Iniciando script $SCRIPT_NAME"

# Detectar arquitectura
ARCH=$(uname -m)
case "$ARCH" in
  aarch64) SYS_ARCH="arm64" ;;
  x86_64) SYS_ARCH="amd64" ;;
  *) log_message "$SCRIPT_NAME" "Arquitectura desconocida: $ARCH"; exit 1 ;;
esac

export SYS_ARCH
log_message "$SCRIPT_NAME" "Arquitectura detectada: $SYS_ARCH"

# Detectar red
if ip link show up | grep -q "state UP"; then
  log_message "$SCRIPT_NAME" "Interfaz de red detectada y activa"
else
  log_message "$SCRIPT_NAME" "No se detectó una interfaz de red activa"
fi
