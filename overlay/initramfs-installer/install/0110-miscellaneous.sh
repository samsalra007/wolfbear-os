#!/bin/sh
set -euo pipefail

SCRIPT_NAME=$(basename "$0")

. "$(dirname "$0")/globals-definitions"
. "$(dirname "$0")/util-log"

log_message $SCRIPT_NAME "Iniciando limpieza final"

debug_message $SCRIPT_NAME "Solucionando problemas de ejecución del comando ping"
chmod u+s $TARGET_DISK_DIR/bin/ping

debug_message $SCRIPT_NAME "Configurando módulos para la aceleración de gráficos DRM y VIRTIO"
chroot $TARGET_DISK_DIR /bin/sh -c "modprobe drm"
chroot $TARGET_DISK_DIR /bin/sh -c "modprobe virtio_gpu"
chroot $TARGET_DISK_DIR /bin/sh -c "modprobe drm_kms_helper"

log_message $SCRIPT_NAME "Limpieza final terminada"
