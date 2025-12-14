#!/bin/bash

# Personaliza el inicio de las lineas de la terminal
export PS1='[\u@\h \w] \$ '

# echo "[WolfbearOS] adding /sbin into $PATH"
export PATH=$PATH:/sbin

# Soluciona el error al iniciar nano de que la terminal no es valida
export TERM=linux