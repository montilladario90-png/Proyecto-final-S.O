# Proyecto Final — Sistemas Operativos | Grupo 1

**Universidad del Valle · Tecnología en Desarrollo de Software · 2026-2**

## Integrantes
- Luisa Fernanda Ortega
- Darío Montilla Narváez

## Configuración asignada al Grupo 1

| Componente | Distribución |
|---|---|
| VM gráfica (`g01-grafica`) | Kubuntu 26.04.1 LTS (referencia) |
| VM de consola (`g01-consola`) | Debian 13.8 Trixie (referencia estable) |
| Imagen base del Dockerfile | Ubuntu 24.04 (propuesta para Sprint 3) |

## Documentos del Sprint 0
- [Plan de trabajo](plan/plan-de-trabajo.md)
- [Ficha de verificación de versiones](plan/ficha-version.md)

## Sprint 1 — Montaje
- [Desarrollo completo del Sprint 1](sprint-1/README.md)

> Las versiones de referencia están contrastadas con los anuncios oficiales. La versión instalada se comprueba en cada VM con `cat /etc/os-release` y se registra en [la ficha de versiones](plan/ficha-version.md).

## Sprint 2 — Servicios
- [Desarrollo completo del Sprint 2](sprint-2/README.md)
- [Script gráfico Bash para Kubuntu](scripts/resumen-sistema.sh)
- [Script de consola Bash para Debian](scripts/contar-archivos.sh)

> El Sprint 2 desarrolla la administración de usuarios y permisos, firewall, acceso SSH mediante llaves, scripts Bash, gestión de procesos y Docker Engine. Las pruebas, capturas y video deben completarse con evidencias obtenidas en las máquinas virtuales del grupo.
