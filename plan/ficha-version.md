# Ficha de referencia y verificación de versiones — Grupo 1

**Asignatura:** Sistemas Operativos 750001C  
**Programa:** Tecnología en Desarrollo de Software — Universidad del Valle  
**Periodo:** 2026-2  
**Grupo:** 1  
**Fecha de consulta de las referencias oficiales:** 23 de noviembre de 2026.

> Esta ficha separa dos datos diferentes: la versión oficial de referencia que se recomienda descargar y la versión que realmente queda instalada en cada VM. Las versiones recomendadas se verificaron en las publicaciones oficiales. Los datos de kernel, arquitectura, entorno instalado y fecha de instalación solo se pueden confirmar ejecutando los comandos en la máquina correspondiente.

## 1. Distribuciones asignadas oficialmente al Grupo 1

| Componente | Distribución asignada en la presentación | Uso |
|---|---|---|
| VM con escritorio | Kubuntu | `g01-grafica` |
| VM sin escritorio | Debian | `g01-consola` |
| Imagen base Dockerfile | Ubuntu | Sprint 3 |

La presentación del proyecto, página 11, asigna Kubuntu / Debian / Ubuntu al Grupo 1. No fija números de versión.

## 2. Versiones oficiales de referencia para descargar

| Componente | Versión de referencia | Identificador / nombre | Fecha oficial de publicación | Fuente |
|---|---|---|---|---|
| Kubuntu | 26.04.1 LTS | Resolute Raccoon | 27 de agosto de 2026 | [Anuncio oficial Kubuntu 26.04.1](https://kubuntu.org/news/kubuntu-26-04-1-bullet-proof-kde/) |
| Debian | 13.8 estable | Trixie | 21 de noviembre de 2026 | [Anuncio oficial Debian 13.8](https://www.debian.org/News/2026/20261121) |
| Ubuntu para Docker | Definir con la imagen base del Sprint 3 | Imagen oficial `ubuntu` | Se seleccionará al construir el Dockerfile | [Imagen oficial Ubuntu en Docker Hub](https://hub.docker.com/_/ubuntu) |

**Recomendación para el grupo:** descargar la ISO de Kubuntu 26.04.1 LTS y la ISO netinst amd64 de Debian 13.8. Si el profesor entrega ISO específicas o exige otra versión, prevalece la indicada por el curso. La imagen Ubuntu no se instala como tercera VM en el Sprint 1.

## 3. Referencia técnica de Kubuntu — VM gráfica

**Nombre obligatorio:** `g01-grafica`  
**Responsable propuesto:** Luisa Fernanda Ortega.

| Característica oficial de la versión de referencia | Dato |
|---|---|
| Distribución | Kubuntu |
| Versión recomendada | 26.04.1 LTS |
| Nombre clave | Resolute Raccoon |
| Escritorio | KDE Plasma 6.6 |
| Qt | 6.10.2 |
| KDE Frameworks | 6.24.0 |
| KDE Gear | 25.12.3 |
| Kernel de referencia incluido en la publicación | Linux 7.0 |
| Arquitectura objetivo para VirtualBox en PC | amd64 / x86_64 |
| Gestor de paquetes | APT (dpkg como base de paquetes) |
| Instalador recomendado | ISO de escritorio Kubuntu 26.04.1 |

La versión 26.04.1 es una publicación oficial de Kubuntu. Los componentes anteriores son los datos publicados para esa versión; el kernel y paquetes pueden cambiar al actualizar el sistema. No se debe asumir que la VM conserva exactamente esos números tras instalar actualizaciones.

### 3.1 Comandos para obtener los datos reales de la VM

Ejecutar dentro de Kubuntu:

```bash
cat /etc/os-release
uname -r
uname -m
plasmashell --version
apt --version
dpkg-query -W -f='${Package} ${Version}\n' firefox falkon kate geany
date
```

### 3.2 Resultado que debe registrarse tras la instalación

| Dato | Referencia oficial o método de verificación | Valor instalado |
|---|---|---|
| Distribución | Kubuntu | Se confirma con `/etc/os-release` |
| Versión | 26.04.1 LTS recomendada | Se confirma con `VERSION_ID` y `VERSION` |
| Kernel | Publicación de referencia: Linux 7.0 | Salida de `uname -r` |
| Arquitectura | amd64 / x86_64 recomendada | Salida de `uname -m` |
| Escritorio | KDE Plasma 6.6 en la publicación | Salida de `plasmashell --version` |
| Gestor de paquetes | APT / dpkg | Salida de `apt --version` y `dpkg --version` |
| Fecha de comprobación | Hora del sistema | Salida de `date` |

## 4. Referencia técnica de Debian — VM de consola

**Nombre obligatorio:** `g01-consola`  
**Responsable propuesto:** Darío Montilla Narváez.

| Característica oficial de la versión de referencia | Dato |
|---|---|
| Distribución | Debian |
| Versión recomendada | 13.8 |
| Nombre clave | Trixie |
| Estado | Stable / estable |
| Fecha de Debian 13.8 | 21 de noviembre de 2026 |
| Arquitectura recomendada para VirtualBox en PC | amd64 |
| Gestor de paquetes | APT / dpkg |
| Instalador recomendado | Debian 13.8 netinst amd64 |
| Escritorio | No instalar entorno gráfico; la VM es de consola |

Debian 13.8 es la octava actualización de Debian 13 estable; no es una nueva versión mayor. El instalador actualizado incorpora correcciones de seguridad y problemas importantes. Debian 13 tiene soporte completo hasta el 9 de agosto de 2028 y soporte LTS previsto hasta el 30 de junio de 2030, sujeto a las condiciones de las arquitecturas soportadas.

### 4.1 Comandos para obtener los datos reales de la VM

Ejecutar dentro de Debian:

```bash
cat /etc/os-release
uname -r
uname -m
apt --version
dpkg --version
systemctl get-default
date
```

### 4.2 Resultado que debe registrarse tras la instalación

| Dato | Referencia oficial o método de verificación | Valor instalado |
|---|---|---|
| Distribución | Debian | Se confirma con `/etc/os-release` |
| Versión | 13.8 Trixie recomendada | Se confirma con `VERSION_ID` y `VERSION` |
| Kernel | Se obtiene del sistema instalado | Salida de `uname -r` |
| Arquitectura | amd64 recomendada | Salida de `uname -m` |
| Gestor de paquetes | APT / dpkg | Salida de `apt --version` |
| Modo de inicio | Consola multiusuario | Salida de `systemctl get-default` |
| Fecha de comprobación | Hora del sistema | Salida de `date` |

## 5. Referencia de Ubuntu para Docker — Sprint 3

| Dato | Información |
|---|---|
| Distribución asignada | Ubuntu |
| Imagen oficial | `ubuntu` |
| Repositorio | Docker Hub — Official Image |
| Etiqueta propuesta para fijar reproducibilidad | `24.04` (LTS) |
| Arquitectura | Seleccionada por la plataforma del host, verificar con inspect |
| Momento de uso | Sprint 3, al construir y publicar el Dockerfile |

La etiqueta `24.04` es una sugerencia estable para que el Dockerfile no dependa de una etiqueta móvil como `latest`. Confirma que el docente no haya asignado otra etiqueta antes de usarla.

Comandos de comprobación para cuando Docker esté instalado:

```bash
docker pull ubuntu:24.04
docker image inspect ubuntu:24.04 --format '{{.Os}}/{{.Architecture}} {{.Config.Image}}'
docker image inspect ubuntu:24.04 --format '{{json .RepoDigests}}'
date
```

## 6. Requisitos de instalación y recursos del Sprint 1

| Elemento | Kubuntu — `g01-grafica` | Debian — `g01-consola` |
|---|---:|---:|
| RAM recomendada | 4 GB | 2 GB |
| CPU | 2 vCPU recomendadas | **2 CPU exigidas por la presentación** |
| Disco | 30 GB recomendado | **25 GB exigidos por la presentación** |
| Particionado | `/`, `swap`, `/home` | `/`, `swap`, `/home`, `/var` |
| Red | NAT + Host-only | NAT + el mismo Host-only |
| Aplicaciones / herramientas | Dos navegadores y dos editores | make, rsync, curl, git y wget |
| Conexión remota | Cliente SSH | Servidor SSH |

Las cifras de RAM y el disco de Kubuntu son recomendaciones de organización; la consigna fija expresamente 25 GB y 2 CPU para Debian.

## 7. Resumen de versiones y comandos de verificación

| Sistema | Comando principal | Qué demuestra |
|---|---|---|
| Kubuntu | `cat /etc/os-release` | Distribución y versión instalada |
| Kubuntu | `uname -r` | Kernel instalado |
| Kubuntu | `uname -m` | Arquitectura del sistema |
| Kubuntu | `plasmashell --version` | Versión de KDE Plasma |
| Debian | `cat /etc/os-release` | Distribución y versión instalada |
| Debian | `uname -r` | Kernel instalado |
| Debian | `uname -m` | Arquitectura del sistema |
| Debian | `apt --version` | Versión de APT |
| Ubuntu Docker | `docker image inspect ubuntu:24.04` | Metadatos de la imagen descargada |

## 8. Registro de evidencias de verificación

Para mantener la ficha exacta, las versiones instaladas deben copiarse de la salida de los comandos de las secciones 3.1 y 4.1. No se debe reutilizar la fecha de consulta como si fuera fecha de instalación.

| Evidencia requerida | Comando / captura que la respalda | Responsable de recolectarla |
|---|---|---|
| Versión y kernel de Kubuntu | `cat /etc/os-release`, `uname -r`, `date` | Luisa Fernanda Ortega |
| Arquitectura y KDE Plasma | `uname -m`, `plasmashell --version`, `date` | Luisa Fernanda Ortega |
| Versión y kernel de Debian | `cat /etc/os-release`, `uname -r`, `date` | Darío Montilla Narváez |
| Arquitectura y APT de Debian | `uname -m`, `apt --version`, `date` | Darío Montilla Narváez |
| Imagen Ubuntu Docker | `docker image inspect ubuntu:24.04`, `date` | Darío Montilla Narváez, Sprint 3 |

## 9. Observaciones para el grupo

- Si la ISO instalada no coincide con la versión de referencia, registrar el número que muestre `/etc/os-release` y explicar la diferencia.
- Si se actualiza el kernel tras instalar, registrar el kernel que devuelva `uname -r`; no copiar el kernel de las notas de publicación como si fuera el que está ejecutándose.
- Si se instala Debian con otro medio netinst/DVD, el número de versión se determina después de aplicar las actualizaciones disponibles.
- La versión de la imagen Docker se registra cuando se descargue la imagen en el Sprint 3, no en este Sprint 1.

## 10. Fuentes oficiales consultadas

1. **Kubuntu:** anuncio de lanzamiento de Kubuntu 26.04 LTS, 23 de abril de 2026: https://www.kubuntu.org/news/kubuntu-26-04-release-notes/
2. **Kubuntu:** disponibilidad de las imágenes 26.04.1, 27 de agosto de 2026: https://kubuntu.org/news/kubuntu-26-04-1-bullet-proof-kde/
3. **Debian:** anuncio oficial Debian 13.8, 21 de noviembre de 2026: https://www.debian.org/News/2026/20261121
4. **Debian:** información de ciclo de vida y arquitecturas de Trixie: https://www.debian.org/releases/trixie/index
5. **Ubuntu Official Image:** https://hub.docker.com/_/ubuntu

