#!/bin/sh
set -euo pipefail

SCRIPT_NAME=$(basename "$0")

log_message "$SCRIPT_NAME" "Iniciando script $SCRIPT_NAME"

debug_message "$SCRIPT_NAME" "Creando partición de arranque según arquitectura: $SYS_ARCH"

if [ "$SYS_ARCH" = "amd64" ]; then
  grub-mkimage -O x86_64-efi -o $EFI_BOOT_TARGET_DISK_DIR/bootx64.efi -p "/EFI/BOOT" part_gpt fat ext2 normal configfile linux cpio gfxterm all_video
  echo 'fs0:\boot\grub\bootx64.efi' > $EFI_BOOT_TARGET_DISK_DIR/startup.nsh
elif [ "$SYS_ARCH" = "arm64" ]; then
  grub-mkimage -O arm64-efi -o $EFI_BOOT_TARGET_DISK_DIR/bootaa64.efi -p "/EFI/BOOT" part_gpt fat ext2 normal configfile linux cpio gfxterm all_video
  echo 'fs0:\boot\grub\bootaa64.efi' > $EFI_BOOT_TARGET_DISK_DIR/startup.nsh
else
  debug_message "$SCRIPT_NAME" "Arquitectura no soportada para GRUB: $SYS_ARCH"
  exit 1
fi

debug_message $SCRIPT_NAME "Generando archivo $EFI_BOOT_TARGET_DISK_DIR/grub.cfg"

cat > $EFI_BOOT_TARGET_DISK_DIR/grub.cfg <<EOF
set timeout=0
set default=0

menuentry "WolfbearOS for $SYS_ARCH (ROOTFS)" {
    linux (hd0,gpt2)/boot/Image console=tty0 console=ttyAMA0 root=/dev/sda2 rw
    initrd (hd0,gpt2)/boot/initramfs.la.cpio.xz
}
EOF
