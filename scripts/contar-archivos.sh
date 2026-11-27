#!/usr/bin/env bash
# Cuenta archivos regulares del directorio recibido como argumento.
# Códigos: 0 correcto, 1 directorio inexistente, 2 argumento inválido,
# 3 sin permiso de lectura.
set -u

if [[ $# -ne 1 ]]; then
  echo "Uso: $0 DIRECTORIO" >&2
  exit 2
fi

ruta=$1
if [[ ! -d "$ruta" ]]; then
  echo "Error: no existe el directorio: $ruta" >&2
  exit 1
fi

if [[ ! -r "$ruta" ]]; then
  echo "Error: no hay permiso de lectura: $ruta" >&2
  exit 3
fi

cantidad=$(find "$ruta" -maxdepth 1 -type f | wc -l)
echo "Directorio: $ruta"
echo "Archivos regulares: $cantidad"
exit 0
