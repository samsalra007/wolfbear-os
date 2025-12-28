#!/bin/bash

# Personaliza el inicio de las lineas de la terminal
export PS1='[\u@\h \w] \$ '

# echo "[WolfbearOS] adding /sbin into $PATH and setting installer dir"
export WOLFBEAR_INSTALLER_DIR="/install"

export WOLFBEAR_SYS_ARCH=$(uname -m)
if [ "$WOLFBEAR_SYS_ARCH" = 'aarch64' ] || [ "$WOLFBEAR_SYS_ARCH" = 'arm64' ]; then
	WOLFBEAR_SYS_ARCH='arm64'
else 
	WOLFBEAR_SYS_ARCH='amd64'
fi

export PATH=$PATH:/sbin:$WOLFBEAR_INSTALLER_DIR
