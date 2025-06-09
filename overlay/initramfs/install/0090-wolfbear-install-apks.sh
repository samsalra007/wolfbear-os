#!/bin/sh
set -euo pipefail

SCRIPT_NAME=$(basename "$0")

. "$(dirname "$0")/globals-definitions"
. "$(dirname "$0")/util-log"

log_message "$SCRIPT_NAME" "Iniciando instalación de dependencias apk-tools"

# Instalación separada por categoría
debug_message "$SCRIPT_NAME" "Instalando paquetes esenciales del sistema"
apk add --root "$TARGET_DISK_DIR" \
  apk-tools \
  shadow \
  util-linux \
  e2fsprogs \
  dosfstools \
  parted \
  kmod \
  linux-headers \
  libc-utils \
  file \
  nano

debug_message "$SCRIPT_NAME" "Instalando herramientas de red"
apk add --root "$TARGET_DISK_DIR" \
  dhcpcd \
  openresolv \
  openssh

debug_message "$SCRIPT_NAME" "Instalando herramientas de desarrollo y debugging"
apk add --root "$TARGET_DISK_DIR" \
  strace \
  git

debug_message "$SCRIPT_NAME" "Instalando dependencias gráficas"
apk add --root "$TARGET_DISK_DIR" \
  sdl2-dev sdl2 \
  libdrm libdrm-dev \
  mesa-gbm mesa-dev mesa-dri-gallium mesa-egl \
  libinput libinput-dev \
  expat-dev libffi-dev \
  libxkbcommon

debug_message "$SCRIPT_NAME" "Instalando GRUB UEFI"
apk add --root "$TARGET_DISK_DIR" \
  grub-efi

# Opción: soporte Vulkan desde repositorio edge
# apk add --repository=https://dl-cdn.alpinelinux.org/alpine/edge/main --root "$TARGET_DISK_DIR" \
#   libxshmfence \
#   vulkan-loader \
#   vulkan-tools

log_message "$SCRIPT_NAME" "Instalación de dependencias apk-tools terminada"
