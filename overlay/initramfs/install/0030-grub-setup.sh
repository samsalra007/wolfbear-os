#!/bin/sh
set -euo pipefail

SCRIPT_NAME=$(basename "$0")

. "$(dirname "$0")/globals-definitions"
. "$(dirname "$0")/util-log"

log_message "$SCRIPT_NAME" "Iniciando script $SCRIPT_NAME"

log_message "$SCRIPT_NAME" "Creando partición de arranque según arquitectura: $SYS_ARCH"

if [ "$SYS_ARCH" = "amd64" ]; then
  grub-mkimage -O x86_64-efi -o $EFI_BOOT_TARGET_DISK_DIR/bootx64.efi -p /boot/grub part_gpt fat ext2 normal chain linux configfile
  echo 'fs0:\boot\grub\bootx64.efi' > $EFI_BOOT_TARGET_DISK_DIR/startup.nsh
elif [ "$SYS_ARCH" = "arm64" ]; then
  grub-mkimage -O arm64-efi -o $EFI_BOOT_TARGET_DISK_DIR/bootaa64.efi -p /boot/grub part_gpt fat ext2 normal chain linux configfile
  echo 'fs0:\boot\grub\bootaa64.efi' > $EFI_BOOT_TARGET_DISK_DIR/startup.nsh
else
  log_message "$SCRIPT_NAME" "Arquitectura no soportada para GRUB: $SYS_ARCH"
  exit 1
fi
