#!/bin/sh
set -euo pipefail
source /install/util-log
SCRIPT_NAME=$0

log_message $SCRIPT_NAME "Iniciando formateo e instalación de sistema base en disco"

debug_message $SCRIPT_NAME "Selecciona el dispositivo en el cual deseas instalar WolfbearOS:"

lsblk -d -o NAME,SIZE,MODEL | grep -E 'sd|vd|nvme'

read -rp "¿En qué unidad quieres instalar? (/dev/sdX o /dev/vdX): " INSTALLATION_DISK

DEV_DISK="/dev/$(basename "$INSTALLATION_DISK")"

debug_message $SCRIPT_NAME "IMPORTANTE: Recuerda que se eliminará todo el contenido en en $DEV_DISK"

read -rp "¿Deseas continuar? (y/[n]): " CONF

if [ "$CONF" != 'y' ]; then 
  error_message $SCRIPT_NAME "El proceso de instalación no puede continuar. Reiniciando el sistema"
  reboot
fi

debug_message $SCRIPT_NAME "Calculando directorios de particiones"

EFI_PARTITION="${DEV_DISK}1"
ROOTFS_PARTITION="${DEV_DISK}2"

debug_message $SCRIPT_NAME "Generando tabla de particiones en el disco"

parted --script "$DEV_DISK" \
  mklabel gpt \
  mkpart ESP fat32 1MiB 100MiB \
  set 1 esp on \
  mkpart primary ext4 100MiB 100%

debug_message $SCRIPT_NAME "Formateando la unidad y sus particiones"

mkfs.vfat -F 32 "$EFI_PARTITION"
mkfs.ext4 "$ROOTFS_PARTITION"

debug_message $SCRIPT_NAME "Montando particiones"

mkdir -p $TARGET_DISK_DIR
mount "$ROOTFS_PARTITION" "$TARGET_DISK_DIR"

mkdir -p $EFI_TARGET_DISK_DIR
mount "$EFI_PARTITION" "$EFI_TARGET_DISK_DIR"
mkdir -p "$EFI_BOOT_TARGET_DISK_DIR"

cp $INSTALL_RESOURCES_DIR/linux-kernel/Image "$BOOT_DIR/"
cp $INSTALL_RESOURCES_DIR/linux-kernel/initramfs.cpio.xz "$BOOT_DIR/"

log_message $SCRIPT_NAME "Instalación del sistema base en disco finalizada"