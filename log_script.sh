#!/bin/bash

# Verificar que se pasó el parámetro necesario
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 ip_del_servidor"
    exit 1
fi

# Parámetros
SERVER_IP=$1
REMOTE_USER="root"
REMOTE_PATH="/var/log"
LOCAL_PATH="."
PORT=397

# Copiar la carpeta /var/log completa desde el servidor remoto usando el puerto 397
scp -P $PORT -r "${REMOTE_USER}@${SERVER_IP}:${REMOTE_PATH}" "${LOCAL_PATH}"

# Verificar si la copia fue exitosa
if [ $? -eq 0 ]; then
    echo "Carpeta ${REMOTE_PATH} copiada exitosamente a ${LOCAL_PATH}"
else
    echo "Error al copiar la carpeta ${REMOTE_PATH}"
    exit 1
fi
