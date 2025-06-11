#!/bin/sh
set -euo pipefail

SCRIPT_NAME=$(basename "$0")

. "$(dirname "$0")/globals-definitions"
. "$(dirname "$0")/util-log"

log_message $SCRIPT_NAME "Procediendo con la descarga de dependencias Qt"

apk add --root $TARGET_DISK_DIR \
    qt6-qtdeclarative \
    qt6-qtshadertools \
    qt6-qtimageformats \
    qt6-qt5compat

debug_message $SCRIPT_NAME "Ajustando enlaces simbólicos Qt.QtQml"
mkdir -p "$TARGET_DISK_DIR/usr/include/qt6/QtQml/$QT_VERSION"
cd "$TARGET_DISK_DIR/usr/include/qt6/QtQml/$QT_VERSION"
ln -sf ../../QtQml QtQml

debug_message $SCRIPT_NAME "Ajustando enlaces simbólicos Qt.QtCore"
mkdir -p "$TARGET_DISK_DIR/usr/include/qt6/QtCore/$QT_VERSION"
cd "$TARGET_DISK_DIR/usr/include/qt6/QtCore/$QT_VERSION"
ln -sf ../../QtCore QtCore

log_message $SCRIPT_NAME "Proceso de instalación y configuración de Qt realizado exitosamente"