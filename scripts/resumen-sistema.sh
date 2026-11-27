#!/usr/bin/env bash
# Script gráfico del Grupo 1: resumen básico del equipo.
# Requisito Sprint 2: función, if, ciclo y comentarios.
set -u

mostrar_resumen() {
  echo "Equipo: $(hostname)"
  echo "Usuario: $(whoami)"
  echo "Fecha: $(date)"
}

mostrar_resumen

# Comprobar que df esté disponible antes de consultar almacenamiento.
if command -v df >/dev/null 2>&1; then
  echo "Uso de almacenamiento:"
  for ruta in / /home; do
    if mountpoint -q "$ruta"; then
      df -h "$ruta" | tail -n 1
    fi
  done
else
  echo "No se encontró el comando df"
fi

read -r -p "Presiona Enter para cerrar..."
