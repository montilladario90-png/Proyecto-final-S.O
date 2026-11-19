# Ficha de verificación de versiones — Grupo 1

**Asignatura:** Sistemas Operativos 750001C  
**Periodo:** 2026-2  
**Grupo:** 1  
**Fecha de verificación:** completar el día en que se ejecuten las comprobaciones.

> Esta ficha se completa con datos obtenidos en las instalaciones reales. No se deben asumir ni inventar números de versión antes de verificar los sistemas.

## 1. Distribuciones asignadas

| Componente | Distribución asignada | Nombre / uso |
|---|---|---|
| Máquina virtual con escritorio | Kubuntu | `g01-grafica` |
| Máquina virtual sin escritorio | Debian | `g01-consola` |
| Imagen base para Dockerfile | Ubuntu | Imagen que se usará en Sprint 3 |

## 2. Verificación de Kubuntu — VM gráfica

**Responsable de instalación y registro:** Luisa Fernanda Ortega.

| Dato | Resultado verificado |
|---|---|
| Edición y versión de Kubuntu | Pendiente de verificar |
| Versión del kernel | Pendiente de verificar |
| Arquitectura | Pendiente de verificar |
| Entorno de escritorio y versión | Pendiente de verificar |
| Gestor de paquetes | APT / dpkg (confirmar en el sistema) |
| Fecha de verificación | Pendiente |

Comandos sugeridos:

```bash
cat /etc/os-release
uname -r
uname -m
plasmashell --version
date
```

Guardar la salida y una captura original donde se vean el prompt y la fecha.

## 3. Verificación de Debian — VM de consola

**Responsable de instalación y registro:** Darío Montilla Narváez.

| Dato | Resultado verificado |
|---|---|
| Edición y versión de Debian | Pendiente de verificar |
| Versión del kernel | Pendiente de verificar |
| Arquitectura | Pendiente de verificar |
| Gestor de paquetes | APT / dpkg (confirmar en el sistema) |
| Entorno | Linux sin escritorio |
| Fecha de verificación | Pendiente |

Comandos sugeridos:

```bash
cat /etc/os-release
uname -r
uname -m
apt --version
date
```

Guardar la salida y una captura original donde se vean el prompt y la fecha.

## 4. Verificación de la imagen base de Ubuntu para Docker

| Dato | Resultado verificado |
|---|---|
| Distribución base asignada | Ubuntu |
| Etiqueta / versión elegida | Pendiente de definir en Sprint 3 |
| Arquitectura de la imagen | Pendiente de verificar |
| Fuente | Imagen oficial de Ubuntu en Docker Hub |
| Fecha de verificación | Pendiente |

Cuando se defina la etiqueta en el Dockerfile, ejecutar los comandos correspondientes, reemplazando `<etiqueta>` por la versión realmente seleccionada:

```bash
docker pull ubuntu:<etiqueta>
docker image inspect ubuntu:<etiqueta>
date
```

Registrar la etiqueta exacta y la arquitectura que informe Docker.

## 5. Registro de evidencias

| Elemento | Verificado por | Fecha | Evidencia |
|---|---|---|---|
| Kubuntu (`g01-grafica`) | Luisa Fernanda Ortega | Pendiente | Agregar captura original |
| Debian (`g01-consola`) | Darío Montilla Narváez | Pendiente | Agregar captura original |
| Imagen Ubuntu para Docker | Darío Montilla Narváez | Pendiente | Agregar salida de `docker image inspect` |

## 6. Observaciones y diferencias encontradas

Completar después de la instalación:

- **Kubuntu:** escribir aquí cualquier diferencia entre la versión prevista y la instalada, o indicar que coincide.
- **Debian:** escribir aquí cualquier diferencia entre la versión prevista y la instalada, o indicar que coincide.
- **Ubuntu en Docker:** registrar la etiqueta de imagen seleccionada y cualquier observación relevante.

## 7. Confirmación del grupo

| Integrante | Confirmación |
|---|---|
| Luisa Fernanda Ortega | Revisar y confirmar los datos de Kubuntu |
| Darío Montilla Narváez | Revisar y confirmar los datos de Debian y Ubuntu para Docker |

**Importante:** esta ficha queda completamente verificada cuando los datos pendientes se reemplacen con los resultados reales y se adjunten las evidencias originales.
