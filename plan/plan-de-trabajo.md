# Plan de trabajo — Grupo 1

**Asignatura:** Sistemas Operativos 750001C  
**Programa:** Tecnología en Desarrollo de Software — Universidad del Valle  
**Periodo:** 2026-2  
**Grupo:** 1  
**Sede de referencia:** Santander de Quilichao

## 1. Integrantes y organización

| Integrante | Responsabilidades principales propuestas |
|---|---|
| Luisa Fernanda Ortega | Instalación y verificación de la VM gráfica Kubuntu; apoyo en pruebas, evidencias visuales y organización del sitio web |
| Darío Montilla Narváez | Instalación y verificación de la VM de consola Debian; red y SSH; apoyo en seguridad, scripts, Docker y Kubernetes |

Esta distribución es una propuesta de organización para iniciar el trabajo. Ambos integrantes deben participar en las pruebas, documentación, videos y sustentación. Cada integrante debe usar su propia cuenta de GitHub y realizar sus propios commits.

## 2. Objetivo general

Preparar dos máquinas virtuales conectadas —una con escritorio y otra de consola—, implementar los servicios y herramientas solicitados en los sprints, y documentar el proceso y sus evidencias en el repositorio público y en el sitio web del grupo.

## 3. Configuración asignada al Grupo 1

| Elemento | Asignación |
|---|---|
| Máquina virtual gráfica | Kubuntu 26.04.1 LTS (referencia oficial consultada) |
| Nombre de la VM gráfica | `g01-grafica` |
| Máquina virtual de consola | Debian 13.8 Trixie (referencia estable consultada) |
| Nombre de la VM de consola | `g01-consola` |
| Imagen base del Dockerfile | Ubuntu (`24.04` propuesta para Sprint 3) |

**Nota:** la presentación asigna las distribuciones, pero no obliga a utilizar estos números de versión. Las versiones de referencia fueron contrastadas con los anuncios oficiales; el número instalado se comprueba en cada VM con `cat /etc/os-release` y se anota en `plan/ficha-version.md`.

## 4. Cronograma y actividades

### Sprint 0 — Arranque
**Cierre en Santander:** jueves 19 de noviembre de 2026, 11:55 p. m.  
**Valor:** 0,3 puntos.

- Crear el repositorio público del grupo en GitHub.
- Incluir la carpeta `plan` con los archivos `plan-de-trabajo.md` y `ficha-version.md`.
- Completar la ficha con las versiones que se verifiquen en las instalaciones reales.
- Registrar los integrantes y organizar las responsabilidades.

**Responsables:** Luisa Fernanda Ortega y Darío Montilla Narváez.

### Sprint 1 — Montaje
**Cierre en Santander:** jueves 26 de noviembre de 2026, 11:55 p. m.  
**Valor:** 1,2 puntos.

| Actividad | Responsable propuesto |
|---|---|
| Instalar Kubuntu en `g01-grafica`, con particionado manual de `/`, `swap` y `/home` | Luisa Fernanda Ortega |
| Instalar Debian en `g01-consola`, con disco de 25 GB, 2 CPU y particionado manual de `/`, `swap`, `/home` y `/var` | Darío Montilla Narváez |
| Instalar `make`, `rsync`, `curl`, `git` y `wget` en la VM de consola | Darío Montilla Narváez |
| Configurar la red entre las dos máquinas y comprobar conectividad | Ambos |
| Configurar SSH desde la VM gráfica hacia la VM de consola | Ambos |
| Crear una instantánea por VM con el nombre `instalacion-limpia` | Ambos |
| Documentar los cinco puntos del sprint con capturas, comandos y video de 3 minutos | Ambos |

**Participación individual:** mínimo 2 commits propios por integrante, con mensajes descriptivos y fechas dentro del sprint.

### Sprint 2 — Servicios
**Cierre en Santander:** jueves 10 de diciembre de 2026, 11:55 p. m.  
**Valor:** 1,2 puntos.

| Actividad | Responsable propuesto |
|---|---|
| Crear usuarios —uno por integrante—, grupo `proyecto` y carpeta `/srv/proyecto` en Debian | Darío Montilla Narváez |
| Configurar permisos, un usuario con `sudo` y otro sin `sudo`; demostrar `chmod` y `chown` | Darío Montilla Narváez |
| Configurar firewall: permitir SSH, denegar el resto y demostrar el puerto 8080 cerrado y luego abierto | Darío Montilla Narváez |
| Configurar acceso SSH mediante llave y actualizar el sistema | Darío Montilla Narváez |
| Crear el script gráfico Bash con función, condicional, ciclo y comentarios; ejecutarlo desde un ícono | Luisa Fernanda Ortega |
| Crear el script de consola con argumento, validaciones y código de salida distinto de cero cuando falle | Darío Montilla Narváez |
| Probar procesos con `ps`, `top`, `kill`, `nice` y `renice`, y documentar estados R, S, T y Z | Ambos |
| Instalar Docker Engine y comprobar que `hello-world` funciona | Darío Montilla Narváez |
| Documentar los ocho puntos con capturas, comandos y video de 4 minutos | Ambos |

**Participación individual:** mínimo 2 commits propios por integrante, con mensajes descriptivos y fechas dentro del sprint.

### Sprint 3 — Cierre
**Cierre en Santander:** jueves 17 de diciembre de 2026, 11:55 p. m.  
**Valor:** 1,3 puntos.

| Actividad | Responsable propuesto |
|---|---|
| Construir y comentar el Dockerfile usando Ubuntu como imagen base asignada | Darío Montilla Narváez |
| Construir, ejecutar, inspeccionar y administrar el contenedor | Darío Montilla Narváez |
| Publicar la imagen en Docker Hub, borrar la copia local, descargarla nuevamente y documentar el README de la imagen | Darío Montilla Narváez |
| Configurar Minikube con 3 GB y sin `sudo`; desplegar 2 réplicas, probar `exec`, escalar y eliminar un pod | Darío Montilla Narváez |
| Completar el sitio web con portada, distribuciones y ficha, páginas por sprint, comparativo del instalador (mínimo 6 filas), conclusiones individuales y declaración de uso de IA | Luisa Fernanda Ortega |
| Revisar evidencias, comandos, videos y enlaces | Ambos |
| Documentar el sprint con capturas, comandos y video de 5 minutos | Ambos |

**Participación individual:** mínimo 2 commits propios por integrante, con mensajes descriptivos y fechas dentro del sprint.

### Sustentación
**Fecha de referencia en Santander:** viernes 18 de diciembre de 2026.  
**Valor:** 1,0 punto.

- Realizar una presentación grupal de aproximadamente 6 minutos, usando el sitio como apoyo.
- Participar ambos integrantes.
- Explicar una diferencia entre las distribuciones utilizadas y otras distribuciones, por ejemplo instalador, gestor de paquetes o firewall.
- Cada integrante realiza una prueba individual de aproximadamente 2 minutos: responder una pregunta técnica, ejecutar un comando en vivo y explicar la parte que tiene asignada en este plan.
- Encender las dos máquinas virtuales antes de la llegada del docente.

## 5. Reglas de trabajo y evidencias

1. Cada integrante trabaja con su propia cuenta de GitHub.
2. Cada integrante realiza 2 commits por sprint (6 en total), con mensajes que indiquen qué cambió.
3. Las capturas deben mostrar el prompt y el comando `date`; deben ser originales, sin recortes ni ediciones.
4. Los videos deben ser continuos, con la duración indicada para cada sprint y con todos los integrantes apareciendo con su cara.
5. El código de cada sprint se guarda en `codigo_sprintN.txt` en las dos VMs y se muestra con `cat` y `date`.
6. La IA puede usarse para aprender comandos, comprender errores o construir el sitio, pero no para producir evidencias ni redactar las explicaciones del trabajo. Se debe declarar su uso.
7. Registrar las versiones, resultados, comandos y evidencias después de verificarlos en las máquinas reales. No se deben inventar datos.

## 6. Seguimiento de entregables

| Entregable | Estado inicial | Evidencia / enlace |
|---|---|---|
| Repositorio público y carpeta `plan` | En preparación | URL del repositorio |
| Ficha de versiones verificada | Pendiente de instalación/verificación | `plan/ficha-version.md` |
| Sprint 1 — Montaje | Pendiente | Página, capturas, comandos y video |
| Sprint 2 — Servicios | Pendiente | Página, capturas, comandos y video |
| Sprint 3 — Cierre | Pendiente | Página, capturas, comandos y video |
| Sitio GitHub Pages | Pendiente de publicación | URL del sitio |

---

**Nota:** los responsables indicados son una propuesta inicial para organizarse. Las actividades colaborativas se realizan y documentan entre ambos; la participación individual se demuestra mediante evidencias, videos y el historial de commits.
