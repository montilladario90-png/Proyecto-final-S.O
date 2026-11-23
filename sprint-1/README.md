# Sprint 1 — Montaje: dos máquinas virtuales y su red

**Asignatura:** Sistemas Operativos 750001C  
**Programa:** Tecnología en Desarrollo de Software — Universidad del Valle  
**Periodo:** 2026-2  
**Grupo:** 1  
**Integrantes:** Luisa Fernanda Ortega y Darío Montilla Narváez  
**Valor:** 1,2 puntos  
**Cierre para Santander de Quilichao:** jueves 26 de noviembre de 2026, 11:55 p. m.

> **Estado de esta página:** guía de ejecución y plantilla de evidencias. Los espacios marcados como “Pendiente” deben completarse con datos y capturas de las máquinas instaladas por el grupo. No se deben presentar resultados simulados como si fueran pruebas reales.

## 1. Objetivo del Sprint 1

Instalar y preparar las dos máquinas virtuales asignadas al Grupo 1, configurar la comunicación de red entre ellas, comprobar el acceso SSH desde la máquina gráfica hacia la máquina de consola y guardar una instantánea de cada máquina con el nombre exacto \`instalacion-limpia\`.

### 1.1 Distribuciones asignadas

| Máquina | Distribución | Nombre obligatorio de la VM | Función |
|---|---|---|---|
| Linux con escritorio | Kubuntu | \`g01-grafica\` | Dos navegadores, dos editores y equipo desde el que se inicia SSH |
| Linux sin escritorio | Debian | \`g01-consola\` | Equipo de consola, destino de ping y servidor SSH |
| Imagen base Docker | Ubuntu | No aplica en este sprint | Se utilizará en el Sprint 3 |

La tabla de asignaciones del proyecto indica Kubuntu, Debian y Ubuntu para el Grupo 1. La imagen Ubuntu se utilizará más adelante en el Dockerfile; no es una tercera máquina virtual de este sprint.

## 2. Configuración de las máquinas virtuales en VirtualBox

Los requisitos expresos del proyecto para la VM de consola son un disco virtual de 25 GB y 2 CPU. La consigna no fija la RAM ni el tamaño del disco de Kubuntu. Por eso, los valores identificados como recomendados son una propuesta inicial que se debe ajustar a la capacidad del computador anfitrión.

### 2.1 Tabla general de recursos

| Parámetro | \`g01-grafica\` — Kubuntu | \`g01-consola\` — Debian | Tipo de dato |
|---|---:|---:|---|
| Tipo de sistema | Linux / Ubuntu 64-bit (o perfil Linux equivalente) | Linux / Debian 64-bit | Configuración de VirtualBox |
| Memoria RAM | 4 GB recomendados | 2 GB recomendados | Propuesta ajustable; no fijada en la consigna |
| Procesadores | 2 recomendados | 2 | 2 CPU en Debian: requisito del proyecto |
| Disco duro virtual | 30 GB propuestos | 25 GB | 25 GB en Debian: requisito del proyecto |
| Tipo de disco | VDI, dinámico | VDI, dinámico | Recomendación |
| Adaptador 1 | NAT | NAT | Requisito del esquema de red |
| Adaptador 2 | Adaptador solo-anfitrión (Host-only) | El mismo adaptador solo-anfitrión | Requisito del esquema de red |
| Nombre de VM | \`g01-grafica\` | \`g01-consola\` | Nombre según número de grupo |

**Importante:** no asignes más memoria o CPU de la que puede proporcionar el equipo anfitrión. Los 4 GB y 2 GB de RAM son sugerencias de configuración, no valores que deban declararse como exigencia del docente.

### 2.2 Pasos para crear cada VM

1. Abrir VirtualBox y seleccionar **Nueva**.
2. Escribir exactamente el nombre de la máquina: \`g01-grafica\` o \`g01-consola\`.
3. Seleccionar la imagen ISO correspondiente: Kubuntu para la gráfica y Debian para la consola.
4. Asignar la RAM y los procesadores según la tabla anterior y los recursos disponibles.
5. Crear un disco virtual VDI de tamaño dinámico.
6. Asignar 30 GB a Kubuntu como propuesta y 25 GB a Debian como exige la consigna.
7. Antes de iniciar la instalación, configurar los dos adaptadores de red indicados en la sección 5.
8. Instalar cada sistema operativo siguiendo el particionado manual de la sección 3.

### 2.3 Registro real de recursos asignados

| Dato | Kubuntu — valor real | Debian — valor real |
|---|---|---|
| RAM asignada | Pendiente | Pendiente |
| CPU asignadas | Pendiente | Pendiente |
| Tamaño del disco virtual | Pendiente | Pendiente |
| Tipo de disco | Pendiente | Pendiente |
| Nombre exacto de la VM | Pendiente de comprobar | Pendiente de comprobar |
| Archivo ISO utilizado | Pendiente | Pendiente |

## 3. Particionado manual de discos

El proyecto solicita particionado manual. En Kubuntu se deben crear las particiones \`/\`, \`swap\` y \`/home\`. En Debian se deben crear \`/\`, \`swap\`, \`/home\` y \`/var\`. La consigna también pide escribir una frase que justifique el tamaño de cada partición.

Los tamaños de las tablas siguientes son una **propuesta de distribución**, no tamaños impuestos por el profesor. Se han elegido para que las sumas coincidan con los tamaños de disco de esta guía.

### 3.1 Kubuntu — disco propuesto de 30 GB

| Partición | Tamaño propuesto | Sistema de archivos / tipo | Punto de montaje | Justificación del tamaño |
|---|---:|---|---|---|
| Raíz | 20 GB | ext4 | \`/\` | Se reserva la mayor parte del disco para el sistema operativo, actualizaciones, bibliotecas y aplicaciones. |
| Swap | 2 GB | Área de intercambio | \`swap\` | Aporta memoria de intercambio cuando la RAM disponible no es suficiente. |
| Home | 8 GB | ext4 | \`/home\` | Reserva espacio para los archivos, configuraciones y documentos del usuario. |
| **Total** | **30 GB** |  |  | **Coincide con el disco virtual propuesto.** |

### 3.2 Debian — disco obligatorio de 25 GB

| Partición | Tamaño propuesto | Sistema de archivos / tipo | Punto de montaje | Justificación del tamaño |
|---|---:|---|---|---|
| Raíz | 8 GB | ext4 | \`/\` | Contiene el sistema Debian, sus herramientas y los paquetes básicos de administración. |
| Swap | 2 GB | Área de intercambio | \`swap\` | Permite utilizar espacio de intercambio cuando la memoria RAM se encuentra bajo presión. |
| Home | 5 GB | ext4 | \`/home\` | Almacena los directorios personales y los archivos de trabajo de los usuarios. |
| Var | 10 GB | ext4 | \`/var\` | Reserva espacio para registros, caché, datos variables y el crecimiento de servicios; también deja margen para el trabajo posterior con Docker. |
| **Total** | **25 GB** |  |  | **Coincide con el disco virtual requerido.** |

### 3.3 Criterios para realizar el particionado

- Seleccionar la opción de particionado manual del instalador.
- Comprobar que el disco seleccionado es el disco virtual de la VM y no otro dispositivo.
- Crear las particiones y asignar a cada una su punto de montaje.
- Seleccionar ext4 para las particiones de archivos y tipo swap para el intercambio.
- Revisar el resumen antes de confirmar los cambios en el disco.
- Registrar los tamaños que realmente muestra el instalador; pueden existir pequeñas diferencias entre GB y GiB.

**Nota de arranque UEFI:** si la máquina virtual se configura para iniciar mediante UEFI, el instalador puede requerir una partición de sistema EFI adicional (FAT32, marcada como EFI System Partition). Esa partición no está incluida en las sumas propuestas de las tablas; se debe tener en cuenta al dimensionar el disco. No se debe eliminar una partición EFI que el modo de arranque necesite.

### 3.4 Comandos para comprobar el particionado instalado

Ejecutar en ambas máquinas después de instalar:

\`\`\`bash
lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINTS
findmnt
swapon --show
free -h
date
\`\`\`

En la VM de Debian, verificar específicamente los puntos de montaje:

\`\`\`bash
findmnt /
findmnt /home
findmnt /var
swapon --show
lsblk -f
date
\`\`\`

En Kubuntu:

\`\`\`bash
findmnt /
findmnt /home
swapon --show
lsblk -f
date
\`\`\`

### 3.5 Registro de particiones reales

| VM | Partición | Tamaño real | Sistema de archivos | Punto de montaje real | Verificado |
|---|---|---:|---|---|---|
| Kubuntu | Raíz | Pendiente | Pendiente | \`/\` | Pendiente |
| Kubuntu | Swap | Pendiente | swap | swap | Pendiente |
| Kubuntu | Home | Pendiente | Pendiente | \`/home\` | Pendiente |
| Debian | Raíz | Pendiente | Pendiente | \`/\` | Pendiente |
| Debian | Swap | Pendiente | swap | swap | Pendiente |
| Debian | Home | Pendiente | Pendiente | \`/home\` | Pendiente |
| Debian | Var | Pendiente | Pendiente | \`/var\` | Pendiente |

## 4. Instalación de aplicaciones y herramientas

### 4.1 Kubuntu — dos navegadores y dos editores

La VM gráfica debe quedar con dos navegadores y dos editores instalados. Para esta guía se propone la siguiente selección:

| Tipo | Aplicación | Función | Comando de instalación |
|---|---|---|---|
| Navegador 1 | Firefox | Navegación web y consulta de documentación | \`sudo apt install -y firefox\` |
| Navegador 2 | Falkon | Segundo navegador, basado en tecnologías KDE/Qt | \`sudo apt install -y falkon\` |
| Editor 1 | Kate | Editor de texto avanzado del entorno KDE | \`sudo apt install -y kate\` |
| Editor 2 | Geany | Editor ligero con funciones para código | \`sudo apt install -y geany\` |

Instalar y actualizar:

\`\`\`bash
sudo apt update
sudo apt install -y firefox falkon kate geany
\`\`\`

Comprobar los paquetes:

\`\`\`bash
dpkg -l firefox falkon kate geany
date
\`\`\`

Comprobar versiones cuando los ejecutables estén disponibles:

\`\`\`bash
firefox --version
falkon --version
kate --version
geany --version
date
\`\`\`

**Observación:** Firefox puede venir preinstalado. En ese caso, el gestor de paquetes indicará que ya se encuentra instalado; no es necesario instalarlo de nuevo. Si alguno de los paquetes no está disponible en los repositorios habilitados, registrar el mensaje y consultar antes de reemplazarlo por otra aplicación.

### 4.2 Debian — herramientas requeridas

La VM de consola debe tener instaladas las siguientes herramientas:

| Herramienta | Función | Comando para comprobarla |
|---|---|---|
| make | Automatiza compilaciones y tareas definidas en Makefile | \`make --version\` |
| rsync | Sincroniza archivos y directorios | \`rsync --version\` |
| curl | Realiza transferencias y solicitudes mediante URL | \`curl --version\` |
| git | Control de versiones del proyecto | \`git --version\` |
| wget | Descarga archivos desde la web | \`wget --version\` |
| openssh-server | Permite recibir conexiones SSH | \`systemctl status ssh\` |

Instalar los paquetes:

\`\`\`bash
sudo apt update
sudo apt install -y make rsync curl git wget openssh-server
\`\`\`

Si el usuario de Debian no tiene habilitado \`sudo\`, ejecutar la instalación desde una sesión de administrador:

\`\`\`bash
su -
apt update
apt install -y make rsync curl git wget openssh-server
exit
\`\`\`

Comprobar versiones y disponibilidad:

\`\`\`bash
make --version
rsync --version
curl --version
git --version
wget --version
date
\`\`\`

En Debian, habilitar e iniciar el servicio SSH:

\`\`\`bash
sudo systemctl enable --now ssh
sudo systemctl status ssh --no-pager
\`\`\`

Si se administró la instalación como root, ejecutar el comando de servicio desde esa sesión sin anteponer \`sudo\`.

### 4.3 Registro de instalación real

| VM | Aplicación o herramienta | Estado | Versión instalada | Observaciones |
|---|---|---|---|---|
| Kubuntu | Firefox | Pendiente | Pendiente | Registrar si ya venía instalado |
| Kubuntu | Falkon | Pendiente | Pendiente | Pendiente |
| Kubuntu | Kate | Pendiente | Pendiente | Pendiente |
| Kubuntu | Geany | Pendiente | Pendiente | Pendiente |
| Debian | make | Pendiente | Pendiente | Pendiente |
| Debian | rsync | Pendiente | Pendiente | Pendiente |
| Debian | curl | Pendiente | Pendiente | Pendiente |
| Debian | git | Pendiente | Pendiente | Pendiente |
| Debian | wget | Pendiente | Pendiente | Pendiente |
| Debian | openssh-server | Pendiente | Pendiente | Necesario para el acceso SSH |

## 5. Configuración de red en VirtualBox

El esquema de la presentación utiliza dos adaptadores por máquina:

1. **Adaptador 1 — NAT:** brinda salida a Internet a cada VM.
2. **Adaptador 2 — solo-anfitrión (Host-only):** permite que las dos VM se comuniquen entre sí mediante una red privada del anfitrión.

La presentación advierte que, si se deja únicamente NAT, las dos VM pueden recibir la misma dirección (por ejemplo, 10.0.2.15) y no se ven directamente entre sí.

### 5.1 Tabla de configuración de adaptadores

| Máquina virtual | Adaptador | Modo de conexión | Uso |
|---|---|---|---|
| \`g01-grafica\` | Adaptador 1 | NAT | Acceso a Internet |
| \`g01-grafica\` | Adaptador 2 | Solo-anfitrión (Host-only) | Comunicación privada con Debian |
| \`g01-consola\` | Adaptador 1 | NAT | Acceso a Internet |
| \`g01-consola\` | Adaptador 2 | El mismo Host-only usado por Kubuntu | Comunicación privada con Kubuntu |

### 5.2 Pasos en VirtualBox

Realizar estos pasos en cada VM:

1. Apagar la máquina virtual.
2. Seleccionarla en VirtualBox y abrir **Configuración → Red**.
3. En **Adaptador 1**, activar **Habilitar adaptador de red** y seleccionar **NAT**.
4. En **Adaptador 2**, activar **Habilitar adaptador de red**.
5. Seleccionar **Adaptador solo-anfitrión (Host-only Adapter)**.
6. Elegir en ambas VM el mismo adaptador de red solo-anfitrión.
7. Guardar la configuración e iniciar las dos máquinas.

### 5.3 Identificación de direcciones IP

Ejecutar en Kubuntu y Debian:

\`\`\`bash
ip -br addr
ip route
hostname -I
date
\`\`\`

Identificar la dirección correspondiente al adaptador Host-only, no confundirla con la dirección de NAT ni con \`127.0.0.1\` (loopback).

### 5.4 Tabla para registrar las direcciones reales

| Dato | Kubuntu — \`g01-grafica\` | Debian — \`g01-consola\` |
|---|---|---|
| Interfaz NAT | Pendiente | Pendiente |
| IP asignada por NAT | Pendiente | Pendiente |
| Interfaz Host-only | Pendiente | Pendiente |
| IP Host-only | Pendiente | Pendiente |
| Máscara / prefijo | Pendiente | Pendiente |
| Puerta de enlace | Pendiente | Pendiente |
| ¿Tiene salida a Internet? | Pendiente | Pendiente |

**Importante:** no copiar direcciones IP de ejemplos ni asumir que VirtualBox asignó una dirección concreta. Registrar la dirección que realmente aparece en \`ip -br addr\`. Si el adaptador Host-only no obtiene una IP, revisar que ambas VM usen el mismo adaptador y que su DHCP esté habilitado o configurar direcciones compatibles con la red privada creada en VirtualBox.

## 6. Pruebas de conectividad: ping y SSH

### 6.1 Prueba de Internet por NAT

En cada VM:

\`\`\`bash
ping -c 4 deb.debian.org
\`\`\`

Resultado esperado: recepción de respuestas del dominio, siempre que la red anfitriona y DNS funcionen. Registrar el resultado real, incluso si falla.

| VM | Comando | Resultado real | Estado |
|---|---|---|---|
| Kubuntu | \`ping -c 4 deb.debian.org\` | Pendiente | Pendiente |
| Debian | \`ping -c 4 deb.debian.org\` | Pendiente | Pendiente |

### 6.2 Prueba de ping entre las dos VM

Desde Kubuntu, utilizar la IP Host-only real de Debian:

\`\`\`bash
ping -c 4 <IP_HOST_ONLY_DEBIAN>
\`\`\`

Desde Debian, se puede comprobar también la comunicación de regreso:

\`\`\`bash
ping -c 4 <IP_HOST_ONLY_KUBUNTU>
\`\`\`

Resultado esperado: recibir respuestas de la otra VM sin pérdida de paquetes en una conexión estable.

| Origen | Destino | Dirección utilizada | Resultado real | Estado |
|---|---|---|---|---|
| Kubuntu | Debian | IP Host-only de Debian | Pendiente | Pendiente |
| Debian | Kubuntu | IP Host-only de Kubuntu | Pendiente | Pendiente |

### 6.3 Comprobación del servicio SSH en Debian

En \`g01-consola\`:

\`\`\`bash
sudo systemctl enable --now ssh
sudo systemctl status ssh --no-pager
sudo ss -tlnp | grep ':22'
date
\`\`\`

Resultado esperado: el servicio \`ssh\` debe aparecer activo y el puerto TCP 22 debe estar escuchando. Si el servicio no existe, comprobar que \`openssh-server\` esté instalado.

### 6.4 Conexión SSH desde Kubuntu hacia Debian

En \`g01-grafica\`, ejecutar:

\`\`\`bash
ssh <USUARIO_DEBIAN>@<IP_HOST_ONLY_DEBIAN>
\`\`\`

La primera conexión puede mostrar una pregunta de confirmación de la huella del servidor. Verificar que se está conectando a la IP correcta y escribir \`yes\` para continuar. Después, introducir la contraseña del usuario de Debian.

Una vez dentro de Debian, ejecutar:

\`\`\`bash
whoami
hostname
date
exit
\`\`\`

Resultado esperado: la sesión remota muestra el usuario y el nombre de la VM Debian; al escribir \`exit\`, se regresa a la terminal de Kubuntu.

**Alcance:** en este sprint se debe demostrar el acceso SSH. La configuración de llaves para entrar sin contraseña corresponde al Sprint 2 de acuerdo con la presentación.

### 6.5 Tabla de verificación de conectividad

| N.º | Prueba | Equipo donde se ejecuta | Resultado esperado | Resultado real |
|---:|---|---|---|---|
| 1 | Internet por NAT | Kubuntu | Recibe respuestas de \`deb.debian.org\` | Pendiente |
| 2 | Internet por NAT | Debian | Recibe respuestas de \`deb.debian.org\` | Pendiente |
| 3 | Ping entre máquinas | Kubuntu → Debian | Recibe respuestas de la IP Host-only de Debian | Pendiente |
| 4 | Ping de retorno | Debian → Kubuntu | Recibe respuestas de la IP Host-only de Kubuntu | Pendiente |
| 5 | Servicio SSH | Debian | Servicio activo y puerto TCP 22 escuchando | Pendiente |
| 6 | Conexión remota | Kubuntu → Debian | Inicia sesión y ejecuta \`whoami\` y \`hostname\` | Pendiente |

## 7. Instantáneas de VirtualBox

El proyecto exige guardar **una instantánea por cada VM**, ambas con el nombre exacto:

\`instalacion-limpia\`

### 7.1 Procedimiento

1. Comprobar que el sistema operativo inicia correctamente.
2. Confirmar que las particiones, las aplicaciones/herramientas y los adaptadores de red se encuentran configurados.
3. Comprobar que el ping y SSH funcionan.
4. Apagar el sistema operativo de forma normal.
5. En VirtualBox, seleccionar la VM y abrir la sección **Instantáneas (Snapshots)**.
6. Pulsar **Tomar (Take)**.
7. Escribir exactamente \`instalacion-limpia\` como nombre.
8. Guardar y verificar que la instantánea aparece en el árbol de instantáneas.

### 7.2 Registro de instantáneas

| Máquina virtual | Nombre requerido | Nombre registrado en VirtualBox | Fecha de creación | Verificación |
|---|---|---|---|---|
| \`g01-grafica\` — Kubuntu | \`instalacion-limpia\` | Pendiente | Pendiente | Pendiente |
| \`g01-consola\` — Debian | \`instalacion-limpia\` | Pendiente | Pendiente | Pendiente |

## 8. Código de verificación del Sprint 1

La presentación indica que el código del sprint se publica 48 horas antes, que es una cadena corta y no un programa, y que debe guardarse en un archivo llamado \`codigo_sprint1.txt\` en **las dos máquinas virtuales**. El archivo debe mostrarse con \`cat\` y \`date\`.

No se inventa el contenido de esa cadena: se debe copiar exactamente la que publique el docente.

En cada VM, después de recibir el código:

\`\`\`bash
nano ~/codigo_sprint1.txt
\`\`\`

Pegar la cadena oficial, guardar y luego ejecutar:

\`\`\`bash
cat ~/codigo_sprint1.txt
date
\`\`\`

### 8.1 Registro de comprobación

| Máquina | Archivo creado | Contenido oficial copiado | Verificación con \`cat\` | Fecha visible con \`date\` |
|---|---|---|---|---|
| Kubuntu — \`g01-grafica\` | Pendiente | Pendiente | Pendiente | Pendiente |
| Debian — \`g01-consola\` | Pendiente | Pendiente | Pendiente | Pendiente |

## 9. Organización de los cinco puntos de evidencia

La página del Sprint 1 debe incluir una captura por punto, los comandos correspondientes y el video. Para organizar el contenido, se propone esta distribución de los cinco puntos:

| Punto | Contenido que se debe demostrar | Comandos / comprobaciones | Evidencia que se debe adjuntar |
|---:|---|---|---|
| 1 | Kubuntu instalado en \`g01-grafica\`, particiones \`/\`, \`swap\`, \`/home\`, dos navegadores y dos editores | \`lsblk -f\`, \`findmnt\`, \`swapon --show\`, versiones de aplicaciones | Captura de particiones y aplicaciones instaladas |
| 2 | Debian instalado en \`g01-consola\`, disco de 25 GB, 2 CPU, particiones \`/\`, \`swap\`, \`/home\`, \`/var\`, herramientas requeridas | \`lsblk -f\`, \`findmnt\`, \`swapon --show\`, versiones de herramientas | Captura de hardware/particiones y paquetes instalados |
| 3 | Adaptador NAT y adaptador Host-only en ambas VM | \`ip -br addr\`, \`ip route\` | Captura de la configuración de red en VirtualBox y de las IP reales |
| 4 | Comunicación entre máquinas y acceso SSH desde Kubuntu a Debian | \`ping -c 4\`, \`systemctl status ssh\`, \`ssh usuario@IP\`, \`whoami\`, \`hostname\` | Captura del ping exitoso y de la sesión SSH remota |
| 5 | Instantánea de cada VM con el nombre requerido y código oficial en las dos VM | Revisión de Snapshots; \`cat ~/codigo_sprint1.txt\`; \`date\` | Capturas del árbol de instantáneas y del código mostrado en cada máquina |

> Esta tabla es una organización práctica de los cinco puntos para la página del grupo. La consigna original enumera las tareas y exige cinco puntos documentados, pero no asigna títulos oficiales a cada punto.

### 9.1 Nombres sugeridos para los archivos de evidencia

| Archivo | Contenido |
|---|---|
| \`01-kubuntu-particiones-aplicaciones.png\` | Particionado de Kubuntu y aplicaciones |
| \`02-debian-particiones-paquetes.png\` | Particionado de Debian y paquetes |
| \`03-virtualbox-red-adaptadores.png\` | NAT y Host-only en las dos VM |
| \`04-ping-y-ssh.png\` | Ping y sesión SSH |
| \`05-instantaneas-y-codigo.png\` | Instantáneas y verificación del código |

Guardar las imágenes reales en una carpeta como \`sprint-1/evidencias/\` y reemplazar esta tabla por enlaces a los archivos cuando estén subidos.

**Regla de capturas:** cada captura debe mostrar el prompt y el comando \`date\`. No se permiten recortes ni ediciones. Se pueden mostrar varios comandos en una sola captura si se leen completos.

## 10. Video de demostración — 3 minutos

El video debe ser continuo, con todos los integrantes visibles y con su cara. La siguiente tabla propone una distribución del tiempo para cubrir todos los requisitos:

| Tiempo aproximado | Contenido | Responsable sugerido |
|---|---|---|
| 00:00–00:20 | Presentación del Grupo 1 e identificación de las dos VM | Ambos |
| 00:20–00:55 | Mostrar Kubuntu, sus particiones, los dos navegadores y los dos editores | Luisa Fernanda Ortega |
| 00:55–01:30 | Mostrar Debian, sus recursos, particiones y herramientas instaladas | Darío Montilla Narváez |
| 01:30–02:05 | Mostrar los dos adaptadores y las direcciones IP Host-only | Ambos |
| 02:05–02:35 | Ejecutar ping y demostrar acceso SSH desde Kubuntu a Debian | Ambos |
| 02:35–03:00 | Mostrar las dos instantáneas \`instalacion-limpia\` y cerrar la demostración | Ambos |

La duración final debe ser de 3 minutos. La tabla es un guion de organización; el video debe registrar pruebas reales y no animaciones o resultados recreados.

## 11. Distribución de responsabilidades

La siguiente tabla retoma la organización propuesta en el plan de trabajo del grupo. Los dos integrantes deben participar en las verificaciones y evidencias compartidas.

| Integrante | Responsabilidades principales | Evidencias / trabajo individual |
|---|---|---|
| Luisa Fernanda Ortega | Instalar Kubuntu, realizar su particionado, instalar/verificar dos navegadores y dos editores, participar en la red y las pruebas de conexión | Capturas de Kubuntu, comandos ejecutados y participación en el video |
| Darío Montilla Narváez | Instalar Debian, asignar 25 GB y 2 CPU, realizar el particionado, instalar herramientas y OpenSSH Server, participar en la red y las pruebas | Capturas de Debian, comandos ejecutados y participación en el video |
| Ambos | Configurar los adaptadores en ambas VM, probar ping/SSH, crear instantáneas, revisar evidencias y grabar el video | Revisión mutua y sustentación |

### 11.1 Commits obligatorios

Cada integrante debe realizar como mínimo **dos commits propios durante el Sprint 1**, con su propia cuenta de GitHub y mensajes que expliquen el cambio.

| Integrante | Commit 1 — ejemplo de mensaje | Commit 2 — ejemplo de mensaje | Estado |
|---|---|---|---|
| Luisa Fernanda Ortega | \`Documenta la instalación y particiones de Kubuntu\` | \`Agrega evidencias de aplicaciones y conectividad\` | Pendiente |
| Darío Montilla Narváez | \`Documenta Debian y sus herramientas de consola\` | \`Agrega pruebas de red SSH e instantáneas\` | Pendiente |

Los mensajes son ejemplos; deben describir los cambios que cada persona efectivamente realice. Para que los commits aparezcan a nombre de cada integrante, Luisa debe aceptar la invitación al repositorio y trabajar desde su propia cuenta.

## 12. Lista de comprobación final

| N.º | Requisito | Estado |
|---:|---|---|
| 1 | VM \`g01-grafica\` con Kubuntu instalado | Pendiente |
| 2 | Particionado manual de Kubuntu: \`/\`, \`swap\`, \`/home\` | Pendiente |
| 3 | Dos navegadores instalados en Kubuntu | Pendiente |
| 4 | Dos editores instalados en Kubuntu | Pendiente |
| 5 | VM \`g01-consola\` con Debian instalado | Pendiente |
| 6 | Debian con disco virtual de 25 GB y 2 CPU | Pendiente |
| 7 | Particionado manual de Debian: \`/\`, \`swap\`, \`/home\`, \`/var\` | Pendiente |
| 8 | Instalación de make, rsync, curl, git y wget en Debian | Pendiente |
| 9 | NAT en el adaptador 1 de ambas VM | Pendiente |
| 10 | El mismo Host-only en el adaptador 2 de ambas VM | Pendiente |
| 11 | Ping desde Kubuntu hacia Debian | Pendiente |
| 12 | Acceso SSH desde Kubuntu hacia Debian | Pendiente |
| 13 | Instantánea \`instalacion-limpia\` en Kubuntu | Pendiente |
| 14 | Instantánea \`instalacion-limpia\` en Debian | Pendiente |
| 15 | \`codigo_sprint1.txt\` en las dos VM con la cadena oficial | Pendiente |
| 16 | Página con cinco puntos, capturas y comandos | Pendiente |
| 17 | Video continuo de 3 minutos con los integrantes visibles | Pendiente |
| 18 | Dos commits propios de cada integrante | Pendiente |

## 13. Registro de resultados y observaciones

Completar esta sección después de ejecutar las pruebas:

| Aspecto | Resultado obtenido | Problema encontrado | Solución aplicada |
|---|---|---|---|
| Instalación de Kubuntu | Pendiente | Pendiente | Pendiente |
| Instalación de Debian | Pendiente | Pendiente | Pendiente |
| Particionado | Pendiente | Pendiente | Pendiente |
| Red NAT | Pendiente | Pendiente | Pendiente |
| Red Host-only | Pendiente | Pendiente | Pendiente |
| Ping entre las VM | Pendiente | Pendiente | Pendiente |
| Conexión SSH | Pendiente | Pendiente | Pendiente |
| Instantáneas | Pendiente | Pendiente | Pendiente |

## 14. Conclusión del Sprint 1

**Plantilla para completar con la experiencia real del grupo:**

Durante el Sprint 1 se realizó el montaje de las máquinas virtuales asignadas al Grupo 1: Kubuntu para el entorno gráfico y Debian para el entorno de consola. Se configuraron sus discos y particiones, se instalaron las aplicaciones y herramientas requeridas y se preparó la comunicación mediante NAT y Host-only. Finalmente, se verificó la conectividad con ping, se probó el acceso SSH desde la máquina gráfica hacia la de consola y se guardaron las instantáneas solicitadas. Los resultados, dificultades y soluciones deben describirse aquí una vez terminadas las pruebas.

---

## Referencia de la consigna

Presentación **Proyecto Final — Dos máquinas virtuales, Docker y Kubernetes**, Sistemas Operativos 750001C, Universidad del Valle, semestre 2026-2:
- Página 3: cronograma y fecha de cierre del Sprint 1.
- Página 4: entregables del Sprint 1.
- Página 5: Kubuntu, Debian, particiones, herramientas, NAT, Host-only, ping, SSH e instantáneas.
- Página 10: requisitos de capturas, video, código del sprint y commits.
- Página 11: asignación de distribuciones del Grupo 1.

