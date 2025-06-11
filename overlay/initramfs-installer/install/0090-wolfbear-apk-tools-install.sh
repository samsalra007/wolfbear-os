#!/bin/sh
set -euo pipefail

SCRIPT_NAME=$(basename "$0")

log_message $SCRIPT_NAME "Iniciando instalación de paquetes apk-tools"

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
  openssh \
  openssh-server

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

log_message $SCRIPT_NAME "Instalación de paquetes de apk-tools terminada"