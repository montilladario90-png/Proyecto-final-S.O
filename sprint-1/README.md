# Sprint 1 — Montaje: dos máquinas virtuales y su red

**Asignatura:** Sistemas Operativos 750001C  
**Programa:** Tecnología en Desarrollo de Software — Universidad del Valle  
**Periodo:** 2026-2  
**Grupo:** 1  
**Integrantes:** Luisa Fernanda Ortega y Darío Montilla Narváez  
**Valor:** 1,2 puntos  
**Cierre para Santander de Quilichao:** jueves 26 de noviembre de 2026, 11:55 p. m.

> **Base técnica del documento:** contiene las versiones oficiales de referencia, requisitos del docente, valores recomendados de VirtualBox, particiones, direcciones propuestas, comandos y criterios de aceptación. Los resultados que dependen de ejecutar las máquinas se expresan como resultados esperados y no como pruebas ya realizadas.

## 1. Objetivo del Sprint 1

Instalar y preparar las dos máquinas virtuales asignadas al Grupo 1, configurar la comunicación de red entre ellas, comprobar el acceso SSH desde la máquina gráfica hacia la máquina de consola y guardar una instantánea de cada máquina con el nombre exacto `instalacion-limpia`.

### 1.1 Distribuciones asignadas

| Máquina | Distribución | Nombre obligatorio de la VM | Función |
|---|---|---|---|
| Linux con escritorio | Kubuntu 26.04.1 LTS (ISO oficial disponible) | `g01-grafica` | Dos navegadores, dos editores y equipo desde el que se inicia SSH |
| Linux sin escritorio | Debian 13.8 “Trixie” (publicación estable vigente) | `g01-consola` | Equipo de consola, destino de ping y servidor SSH |
| Imagen base Docker | Ubuntu | No aplica en este sprint | Se utilizará en el Sprint 3 |

La tabla de asignaciones del proyecto indica las familias de distribución Kubuntu, Debian y Ubuntu para el Grupo 1, sin fijar números de versión. Para documentar una referencia vigente se toma Kubuntu 26.04.1 LTS (publicado el 27 de agosto de 2026) y Debian 13.8 Trixie (publicado el 21 de noviembre de 2026). Estas son versiones oficiales disponibles a la fecha de esta documentación; no se declara que ya estén instaladas. La imagen Ubuntu se utilizará más adelante en el Dockerfile; no es una tercera máquina virtual de este sprint.

## 2. Configuración de las máquinas virtuales en VirtualBox

Los requisitos expresos del proyecto para la VM de consola son un disco virtual de 25 GB y 2 CPU. La consigna no fija la RAM ni el tamaño del disco de Kubuntu. Por eso, los valores identificados como recomendados son una propuesta inicial que se debe ajustar a la capacidad del computador anfitrión.

### 2.1 Tabla general de recursos

| Parámetro | `g01-grafica` — Kubuntu | `g01-consola` — Debian | Tipo de dato |
|---|---:|---:|---|
| Tipo de sistema | Linux / Ubuntu 64-bit (o perfil Linux equivalente) | Linux / Debian 64-bit | Configuración de VirtualBox |
| Memoria RAM | 4 GB recomendados | 2 GB recomendados | Propuesta ajustable; no fijada en la consigna |
| Procesadores | 2 recomendados | 2 | 2 CPU en Debian: requisito del proyecto |
| Disco duro virtual | 30 GB propuestos | 25 GB | 25 GB en Debian: requisito del proyecto |
| Tipo de disco | VDI, dinámico | VDI, dinámico | Recomendación |
| Adaptador 1 | NAT | NAT | Requisito del esquema de red |
| Adaptador 2 | Adaptador solo-anfitrión (Host-only) | El mismo adaptador solo-anfitrión | Requisito del esquema de red |
| Nombre de VM | `g01-grafica` | `g01-consola` | Nombre según número de grupo |

**Importante:** no asignes más memoria o CPU de la que puede proporcionar el equipo anfitrión. Los 4 GB y 2 GB de RAM son sugerencias de configuración, no valores que deban declararse como exigencia del docente.

### 2.2 Pasos para crear cada VM

1. Abrir VirtualBox y seleccionar **Nueva**.
2. Escribir exactamente el nombre de la máquina: `g01-grafica` o `g01-consola`.
3. Seleccionar la imagen ISO correspondiente: Kubuntu para la gráfica y Debian para la consola.
4. Asignar la RAM y los procesadores según la tabla anterior y los recursos disponibles.
5. Crear un disco virtual VDI de tamaño dinámico.
6. Asignar 30 GB a Kubuntu como propuesta y 25 GB a Debian como exige la consigna.
7. Antes de iniciar la instalación, configurar los dos adaptadores de red indicados en la sección 5.
8. Instalar cada sistema operativo siguiendo el particionado manual de la sección 3.

### 2.3 Configuración recomendada y requisitos fijos

| Parámetro | `g01-grafica` — Kubuntu | `g01-consola` — Debian |
|---|---:|---:|
| RAM | 4 GB recomendados | 2 GB recomendados |
| Procesadores | 2 vCPU recomendadas | **2 vCPU requeridas** |
| Disco virtual | 30 GB recomendados | **25 GB requeridos** |
| Formato del disco | VDI dinámico | VDI dinámico |
| ISO oficial a descargar | Kubuntu 26.04.1 LTS Desktop | Debian 13.8 Trixie netinst (amd64) |
| Nombre de la VM | `g01-grafica` | `g01-consola` |

Los 25 GB y las 2 CPU de Debian son requisitos expresos de la presentación. Los 30 GB, 4 GB RAM y 2 vCPU de Kubuntu son una configuración sugerida para disponer de un escritorio cómodo; 2 GB RAM para Debian es una sugerencia para un servidor básico. Ajusta la memoria según la RAM física de tu computador anfitrión, sin asignarla toda a las VM.

**Comprobación después de la instalación:**

```bash
hostnamectl
free -h
nproc
lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS
cat /etc/os-release
date
```

Al ejecutar los comandos se obtendrán el nombre del sistema, RAM visible, procesadores visibles, discos y versión instalada. VirtualBox confirma el tamaño exacto del disco virtual en **Configuración → Almacenamiento**.

## 3. Particionado manual de discos

El proyecto solicita particionado manual. En Kubuntu se deben crear las particiones `/`, `swap` y `/home`. En Debian se deben crear `/`, `swap`, `/home` y `/var`. La consigna también pide escribir una frase que justifique el tamaño de cada partición.

Los tamaños de las tablas siguientes son una **propuesta de distribución**, no tamaños impuestos por el profesor. Se han elegido para que las sumas coincidan con los tamaños de disco de esta guía.

### 3.1 Kubuntu — disco propuesto de 30 GB

| Partición | Tamaño propuesto | Sistema de archivos / tipo | Punto de montaje | Justificación del tamaño |
|---|---:|---|---|---|
| Raíz | 20 GB | ext4 | `/` | Se reserva la mayor parte del disco para el sistema operativo, actualizaciones, bibliotecas y aplicaciones. |
| Swap | 2 GB | Área de intercambio | `swap` | Aporta memoria de intercambio cuando la RAM disponible no es suficiente. |
| Home | 8 GB | ext4 | `/home` | Reserva espacio para los archivos, configuraciones y documentos del usuario. |
| **Total** | **30 GB** |  |  | **Coincide con el disco virtual propuesto.** |

### 3.2 Debian — disco obligatorio de 25 GB

| Partición | Tamaño propuesto | Sistema de archivos / tipo | Punto de montaje | Justificación del tamaño |
|---|---:|---|---|---|
| Raíz | 8 GB | ext4 | `/` | Contiene el sistema Debian, sus herramientas y los paquetes básicos de administración. |
| Swap | 2 GB | Área de intercambio | `swap` | Permite utilizar espacio de intercambio cuando la memoria RAM se encuentra bajo presión. |
| Home | 5 GB | ext4 | `/home` | Almacena los directorios personales y los archivos de trabajo de los usuarios. |
| Var | 10 GB | ext4 | `/var` | Reserva espacio para registros, caché, datos variables y el crecimiento de servicios; también deja margen para el trabajo posterior con Docker. |
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

```bash
lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINTS
findmnt
swapon --show
free -h
date
```

En la VM de Debian, verificar específicamente los puntos de montaje:

```bash
findmnt /
findmnt /home
findmnt /var
swapon --show
lsblk -f
date
```

En Kubuntu:

```bash
findmnt /
findmnt /home
swapon --show
lsblk -f
date
```

### 3.5 Distribución de particiones definida para el montaje

| VM | Partición | Tamaño previsto | Formato | Punto de montaje | Finalidad |
|---|---|---:|---|---|---|
| Kubuntu | Raíz | 20 GB | ext4 | `/` | Sistema, aplicaciones y actualizaciones |
| Kubuntu | Swap | 2 GB | swap | swap | Memoria de intercambio |
| Kubuntu | Home | 8 GB | ext4 | `/home` | Archivos y configuración del usuario |
| **Kubuntu** | **Total** | **30 GB** |  |  | **Disco virtual recomendado** |
| Debian | Raíz | 8 GB | ext4 | `/` | Sistema base y utilidades |
| Debian | Swap | 2 GB | swap | swap | Memoria de intercambio |
| Debian | Home | 5 GB | ext4 | `/home` | Archivos personales |
| Debian | Var | 10 GB | ext4 | `/var` | Registros, caché y datos variables; deja espacio para Docker |
| **Debian** | **Total** | **25 GB** |  |  | **Disco virtual requerido** |

La tabla es el esquema definido para el trabajo. Los tamaños son una propuesta de particionado que cumple los puntos de montaje pedidos y suma exactamente los tamaños de disco planeados. En el instalador pueden verse pequeñas diferencias por conversión de GB a GiB. Si se activa UEFI, crea además la partición EFI que solicite el instalador y descuenta su espacio de la partición raíz para mantener el tamaño total del disco.

## 4. Instalación de aplicaciones y herramientas

### 4.1 Kubuntu — dos navegadores y dos editores

La VM gráfica debe quedar con dos navegadores y dos editores instalados. Para esta guía se propone la siguiente selección:

| Tipo | Aplicación | Función | Comando de instalación |
|---|---|---|---|
| Navegador 1 | Firefox | Navegación web y consulta de documentación | `sudo apt install -y firefox` |
| Navegador 2 | Falkon | Segundo navegador, basado en tecnologías KDE/Qt | `sudo apt install -y falkon` |
| Editor 1 | Kate | Editor de texto avanzado del entorno KDE | `sudo apt install -y kate` |
| Editor 2 | Geany | Editor ligero con funciones para código | `sudo apt install -y geany` |

Instalar y actualizar:

```bash
sudo apt update
sudo apt install -y firefox falkon kate geany
```

Comprobar los paquetes:

```bash
dpkg -l firefox falkon kate geany
date
```

Comprobar versiones cuando los ejecutables estén disponibles:

```bash
firefox --version
falkon --version
kate --version
geany --version
date
```

**Observación:** Firefox puede venir preinstalado. En ese caso, el gestor de paquetes indicará que ya se encuentra instalado; no es necesario instalarlo de nuevo. Si alguno de los paquetes no está disponible en los repositorios habilitados, registrar el mensaje y consultar antes de reemplazarlo por otra aplicación.

### 4.2 Debian — herramientas requeridas

La VM de consola debe tener instaladas las siguientes herramientas:

| Herramienta | Función | Comando para comprobarla |
|---|---|---|
| make | Automatiza compilaciones y tareas definidas en Makefile | `make --version` |
| rsync | Sincroniza archivos y directorios | `rsync --version` |
| curl | Realiza transferencias y solicitudes mediante URL | `curl --version` |
| git | Control de versiones del proyecto | `git --version` |
| wget | Descarga archivos desde la web | `wget --version` |
| openssh-server | Permite recibir conexiones SSH | `systemctl status ssh` |

Instalar los paquetes:

```bash
sudo apt update
sudo apt install -y make rsync curl git wget openssh-server
```

Si el usuario de Debian no tiene habilitado `sudo`, ejecutar la instalación desde una sesión de administrador:

```bash
su -
apt update
apt install -y make rsync curl git wget openssh-server
exit
```

Comprobar versiones y disponibilidad:

```bash
make --version
rsync --version
curl --version
git --version
wget --version
date
```

En Debian, habilitar e iniciar el servicio SSH:

```bash
sudo systemctl enable --now ssh
sudo systemctl status ssh --no-pager
```

Si se administró la instalación como root, ejecutar el comando de servicio desde esa sesión sin anteponer `sudo`.

### 4.3 Paquetes y comprobación de instalación

| VM | Aplicación / paquete | Paquete APT | Criterio de verificación |
|---|---|---|---|
| Kubuntu | Firefox | `firefox` | Aparece instalado con `dpkg -l firefox` y abre desde el menú |
| Kubuntu | Falkon | `falkon` | Aparece instalado con `dpkg -l falkon` y abre desde el menú |
| Kubuntu | Kate | `kate` | Aparece instalado con `dpkg -l kate` y abre desde el menú |
| Kubuntu | Geany | `geany` | Aparece instalado con `dpkg -l geany` y abre desde el menú |
| Debian | make | `make` | `make --version` devuelve versión |
| Debian | rsync | `rsync` | `rsync --version` devuelve versión |
| Debian | curl | `curl` | `curl --version` devuelve versión |
| Debian | git | `git` | `git --version` devuelve versión |
| Debian | wget | `wget` | `wget --version` devuelve versión |
| Debian | Servidor SSH | `openssh-server` | `systemctl is-active ssh` devuelve `active` |

Para registrar las versiones exactas de los paquetes que entregue el repositorio configurado en cada VM, ejecutar:

```bash
apt-cache policy firefox falkon kate geany
apt-cache policy make rsync curl git wget openssh-server
```

La versión exacta puede cambiar con las actualizaciones de los repositorios; por eso se registra la versión que muestre `apt-cache policy` en cada máquina, no una cifra estimada.

## 5. Configuración de red en VirtualBox

El esquema de la presentación utiliza dos adaptadores por máquina:

1. **Adaptador 1 — NAT:** brinda salida a Internet a cada VM.
2. **Adaptador 2 — solo-anfitrión (Host-only):** permite que las dos VM se comuniquen entre sí mediante una red privada del anfitrión.

La presentación advierte que, si se deja únicamente NAT, las dos VM pueden recibir la misma dirección (por ejemplo, 10.0.2.15) y no se ven directamente entre sí.

### 5.1 Tabla de configuración de adaptadores

| Máquina virtual | Adaptador | Modo de conexión | Uso |
|---|---|---|---|
| `g01-grafica` | Adaptador 1 | NAT | Acceso a Internet |
| `g01-grafica` | Adaptador 2 | Solo-anfitrión (Host-only) | Comunicación privada con Debian |
| `g01-consola` | Adaptador 1 | NAT | Acceso a Internet |
| `g01-consola` | Adaptador 2 | El mismo Host-only usado por Kubuntu | Comunicación privada con Kubuntu |

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

```bash
ip -br addr
ip route
hostname -I
date
```

Identificar la dirección correspondiente al adaptador Host-only, no confundirla con la dirección de NAT ni con `127.0.0.1` (loopback).

### 5.4 Plan de direccionamiento IPv4 para Host-only

Plan de direccionamiento propuesto: red privada `192.168.56.0/24`, dentro del rango permitido por la documentación de VirtualBox para redes Host-only en hosts Linux y macOS. Antes de usarla, comprueba en el Network Manager que el equipo anfitrión no tenga otra interfaz en esa misma subred.

| Equipo / interfaz | Dirección IPv4 propuesta | Máscara | Puerta de enlace |
|---|---|---|---|
| Adaptador Host-only del anfitrión | `192.168.56.1` | `255.255.255.0 (/24)` | No aplica |
| Kubuntu — `g01-grafica` | **`192.168.56.10`** | `255.255.255.0 (/24)` | No configurar en Host-only |
| Debian — `g01-consola` | **`192.168.56.20`** | `255.255.255.0 (/24)` | No configurar en Host-only |

El adaptador NAT debe conservar DHCP y será el responsable de la puerta de enlace predeterminada y DNS. El adaptador Host-only solo requiere dirección privada y máscara; no debe instalar una segunda ruta predeterminada.

**En VirtualBox:** abre **Herramientas → Red → Redes solo-anfitrión** y crea una red Host-only con IPv4 del anfitrión `192.168.56.1` y máscara `255.255.255.0`. Para reservar `.10` y `.20` a las VM, desactiva el DHCP de la red Host-only o ajusta su rango para que no entregue esas direcciones a otros dispositivos.

**En Kubuntu:** en Configuración del sistema → Red, edita la conexión del segundo adaptador, selecciona IPv4 Manual y añade `192.168.56.10` con prefijo `24`; no establezcas gateway ni DNS en esa conexión privada.

**En Debian:** identifica la interfaz Host-only con `ip -br link`. En el instalador puede asignarse IPv4 manual a esa tarjeta; si ya está instalado, configura la interfaz a través del gestor de red que esté activo, usando `192.168.56.20/24` y sin ruta predeterminada. No supongas que la interfaz se llama `enp0s8`: utiliza el nombre que muestre `ip -br link`.

Para identificar la IP configurada en cada VM:

```bash
ip -br addr
ip route
hostname -I
date
```

| Dato | Kubuntu | Debian |
|---|---|---|
| Interfaz NAT | DHCP de VirtualBox | DHCP de VirtualBox |
| IP Host-only | `192.168.56.10/24` | `192.168.56.20/24` |
| Red Host-only compartida | `192.168.56.0/24` | `192.168.56.0/24` |
| Interfaz del anfitrión | `192.168.56.1/24` | `192.168.56.1/24` |
| Puerta de enlace predeterminada | La que asigne NAT | La que asigne NAT |
| DNS | El que entregue NAT | El que entregue NAT |

Si la red `192.168.56.0/24` ya está ocupada en tu equipo anfitrión, selecciona otra subred privada permitida por VirtualBox y cambia de forma coherente las tres direcciones. No mezcles direcciones de redes diferentes en el mismo adaptador Host-only.

## 6. Pruebas de conectividad: ping y SSH

### 6.1 Prueba de Internet por NAT

En cada VM:

```bash
ping -c 4 deb.debian.org
```

**Resultado esperado:** el dominio resuelve y el sistema puede acceder a Internet. Algunas redes bloquean ICMP; por eso, si `ping` no responde, utiliza también `getent hosts deb.debian.org` para DNS y `curl -I https://deb.debian.org` para probar HTTPS.

| VM | Comando principal | Resultado correcto esperado |
|---|---|---|
| Kubuntu | `ping -c 4 deb.debian.org` | Respuestas recibidas; 0% de pérdida si ICMP está permitido |
| Debian | `ping -c 4 deb.debian.org` | Respuestas recibidas; 0% de pérdida si ICMP está permitido |

### 6.2 Prueba de ping entre las dos VM

Desde Kubuntu, utilizar la dirección propuesta para Debian:

```bash
ping -c 4 192.168.56.20
```

Desde Debian, comprobar la comunicación de regreso:

```bash
ping -c 4 192.168.56.10
```

**Criterio de aceptación:** ambas máquinas reciben respuestas de la dirección Host-only de la otra. Si no hay respuesta, verifica que los dos adaptadores 2 estén conectados al mismo Host-only, que las IP pertenezcan a `192.168.56.0/24` y que no haya reglas de firewall bloqueando ICMP.

| Origen | Destino | Dirección de destino | Resultado correcto esperado |
|---|---|---|---|
| Kubuntu | Debian | `192.168.56.20` | 4 respuestas ICMP |
| Debian | Kubuntu | `192.168.56.10` | 4 respuestas ICMP |

### 6.3 Comprobación del servicio SSH en Debian

En `g01-consola`:

```bash
sudo systemctl enable --now ssh
sudo systemctl status ssh --no-pager
sudo ss -tlnp | grep ':22'
date
```

Resultado esperado: el servicio `ssh` debe aparecer activo y el puerto TCP 22 debe estar escuchando. Si el servicio no existe, comprobar que `openssh-server` esté instalado.

### 6.4 Conexión SSH desde Kubuntu hacia Debian

En `g01-grafica`, ejecutar:

```bash
ssh usuario@192.168.56.20
```

En el comando, sustituye `usuario` por el nombre real de la cuenta que creaste en Debian. La primera conexión puede mostrar una pregunta de confirmación de la huella del servidor. Verifica que la IP sea la de tu VM y escribe `yes` para continuar. Después, introduce la contraseña de esa cuenta.

Una vez dentro de Debian, ejecutar:

```bash
whoami
hostname
date
exit
```

Resultado esperado: la sesión remota muestra el usuario y el nombre de la VM Debian; al escribir `exit`, se regresa a la terminal de Kubuntu.

**Alcance:** en este sprint se debe demostrar el acceso SSH. La configuración de llaves para entrar sin contraseña corresponde al Sprint 2 de acuerdo con la presentación.

### 6.5 Criterios de aceptación de conectividad

| N.º | Prueba | Comando / acción | Criterio para darla por correcta |
|---:|---|---|---|
| 1 | Internet por NAT en Kubuntu | `ping -c 4 deb.debian.org` o comprobación DNS/HTTPS | Resuelve el dominio y tiene salida a Internet |
| 2 | Internet por NAT en Debian | `ping -c 4 deb.debian.org` o comprobación DNS/HTTPS | Resuelve el dominio y tiene salida a Internet |
| 3 | Ping Kubuntu → Debian | `ping -c 4 192.168.56.20` | Recibe respuesta de Debian |
| 4 | Ping Debian → Kubuntu | `ping -c 4 192.168.56.10` | Recibe respuesta de Kubuntu |
| 5 | Servicio SSH en Debian | `systemctl is-active ssh` y `ss -tlnp` | Servicio activo y puerto TCP 22 en escucha |
| 6 | SSH Kubuntu → Debian | `ssh usuario@192.168.56.20` | Abre sesión remota y permite ejecutar `whoami` y `hostname` |

## 7. Instantáneas de VirtualBox

El proyecto exige guardar **una instantánea por cada VM**, ambas con el nombre exacto:

`instalacion-limpia`

### 7.1 Procedimiento

1. Comprobar que el sistema operativo inicia correctamente.
2. Confirmar que las particiones, las aplicaciones/herramientas y los adaptadores de red se encuentran configurados.
3. Comprobar que el ping y SSH funcionan.
4. Apagar el sistema operativo de forma normal.
5. En VirtualBox, seleccionar la VM y abrir la sección **Instantáneas (Snapshots)**.
6. Pulsar **Tomar (Take)**.
7. Escribir exactamente `instalacion-limpia` como nombre.
8. Guardar y verificar que la instantánea aparece en el árbol de instantáneas.

### 7.2 Registro de instantáneas requeridas

| Máquina virtual | Nombre exacto de la instantánea | Momento de creación | Comprobación en VirtualBox |
|---|---|---|---|
| `g01-grafica` — Kubuntu | **`instalacion-limpia`** | Después de instalar, configurar particiones/aplicaciones/red y comprobar conectividad | La instantánea aparece en el árbol de Snapshots de `g01-grafica` |
| `g01-consola` — Debian | **`instalacion-limpia`** | Después de instalar, configurar particiones/herramientas/red y comprobar SSH | La instantánea aparece en el árbol de Snapshots de `g01-consola` |

VirtualBox registra automáticamente la fecha y hora de creación. Conserva una captura del árbol de instantáneas de cada VM como evidencia; no escribas una fecha manual como si fuera la fecha real de creación.

## 8. Código de verificación del Sprint 1

La presentación indica que el código del sprint se publica 48 horas antes, que es una cadena corta y no un programa, y que debe guardarse en un archivo llamado `codigo_sprint1.txt` en **las dos máquinas virtuales**. El archivo debe mostrarse con `cat` y `date`.

No hay un código universal en la presentación. Se debe copiar literalmente el que publique el docente para el Sprint 1.

En cada VM, después de recibir el código:

```bash
nano ~/codigo_sprint1.txt
```

Pegar la cadena oficial, guardar y luego ejecutar:

```bash
cat ~/codigo_sprint1.txt
date
```

### 8.1 Contenido y comprobación del archivo

| Máquina | Ruta del archivo | Contenido | Comprobación exigida |
|---|---|---|---|
| Kubuntu — `g01-grafica` | `~/codigo_sprint1.txt` | Cadena literal publicada por el docente para el Sprint 1 | Ejecutar `cat ~/codigo_sprint1.txt` y luego `date` |
| Debian — `g01-consola` | `~/codigo_sprint1.txt` | La misma cadena literal publicada por el docente | Ejecutar `cat ~/codigo_sprint1.txt` y luego `date` |

La cadena de verificación es una instrucción específica que el docente publica 48 horas antes del cierre. No existe un valor universal que se pueda deducir de la presentación; se debe copiar sin modificar desde el anuncio oficial del curso. No uses una palabra inventada como si fuera el código oficial.

## 9. Organización de los cinco puntos de evidencia

La página del Sprint 1 debe incluir una captura por punto, los comandos correspondientes y el video. Para organizar el contenido, se propone esta distribución de los cinco puntos:

| Punto | Contenido que se debe demostrar | Comandos / comprobaciones | Evidencia que se debe adjuntar |
|---:|---|---|---|
| 1 | Kubuntu instalado en `g01-grafica`, particiones `/`, `swap`, `/home`, dos navegadores y dos editores | `lsblk -f`, `findmnt`, `swapon --show`, versiones de aplicaciones | Captura de particiones y aplicaciones instaladas |
| 2 | Debian instalado en `g01-consola`, disco de 25 GB, 2 CPU, particiones `/`, `swap`, `/home`, `/var`, herramientas requeridas | `lsblk -f`, `findmnt`, `swapon --show`, versiones de herramientas | Captura de hardware/particiones y paquetes instalados |
| 3 | Adaptador NAT y adaptador Host-only en ambas VM | `ip -br addr`, `ip route` | Captura de la configuración de red en VirtualBox y de las IP reales |
| 4 | Comunicación entre máquinas y acceso SSH desde Kubuntu a Debian | `ping -c 4`, `systemctl status ssh`, `ssh usuario@IP`, `whoami`, `hostname` | Captura del ping exitoso y de la sesión SSH remota |
| 5 | Instantánea de cada VM con el nombre requerido y código oficial en las dos VM | Revisión de Snapshots; `cat ~/codigo_sprint1.txt`; `date` | Capturas del árbol de instantáneas y del código mostrado en cada máquina |

> Esta tabla es una organización práctica de los cinco puntos para la página del grupo. La consigna original enumera las tareas y exige cinco puntos documentados, pero no asigna títulos oficiales a cada punto.

### 9.1 Nombres sugeridos para los archivos de evidencia

| Archivo | Contenido |
|---|---|
| `01-kubuntu-particiones-aplicaciones.png` | Particionado de Kubuntu y aplicaciones |
| `02-debian-particiones-paquetes.png` | Particionado de Debian y paquetes |
| `03-virtualbox-red-adaptadores.png` | NAT y Host-only en las dos VM |
| `04-ping-y-ssh.png` | Ping y sesión SSH |
| `05-instantaneas-y-codigo.png` | Instantáneas y verificación del código |

Guardar las imágenes reales en una carpeta como `sprint-1/evidencias/` y reemplazar esta tabla por enlaces a los archivos cuando estén subidos.

**Regla de capturas:** cada captura debe mostrar el prompt y el comando `date`. No se permiten recortes ni ediciones. Se pueden mostrar varios comandos en una sola captura si se leen completos.

## 10. Video de demostración — 3 minutos

El video debe ser continuo, con todos los integrantes visibles y con su cara. La siguiente tabla propone una distribución del tiempo para cubrir todos los requisitos:

| Tiempo aproximado | Contenido | Responsable sugerido |
|---|---|---|
| 00:00–00:20 | Presentación del Grupo 1 e identificación de las dos VM | Ambos |
| 00:20–00:55 | Mostrar Kubuntu, sus particiones, los dos navegadores y los dos editores | Luisa Fernanda Ortega |
| 00:55–01:30 | Mostrar Debian, sus recursos, particiones y herramientas instaladas | Darío Montilla Narváez |
| 01:30–02:05 | Mostrar los dos adaptadores y las direcciones IP Host-only | Ambos |
| 02:05–02:35 | Ejecutar ping y demostrar acceso SSH desde Kubuntu a Debian | Ambos |
| 02:35–03:00 | Mostrar las dos instantáneas `instalacion-limpia` y cerrar la demostración | Ambos |

La duración requerida es de 3 minutos. La tabla es un guion de distribución del tiempo; el video debe mostrar la ejecución real de los comandos y las configuraciones.

## 11. Distribución de responsabilidades

La siguiente tabla retoma la organización propuesta en el plan de trabajo del grupo. Los dos integrantes deben participar en las verificaciones y evidencias compartidas.

| Integrante | Responsabilidades principales | Evidencias / trabajo individual |
|---|---|---|
| Luisa Fernanda Ortega | Instalar Kubuntu, realizar su particionado, instalar/verificar dos navegadores y dos editores, participar en la red y las pruebas de conexión | Capturas de Kubuntu, comandos ejecutados y participación en el video |
| Darío Montilla Narváez | Instalar Debian, asignar 25 GB y 2 CPU, realizar el particionado, instalar herramientas y OpenSSH Server, participar en la red y las pruebas | Capturas de Debian, comandos ejecutados y participación en el video |
| Ambos | Configurar los adaptadores en ambas VM, probar ping/SSH, crear instantáneas, revisar evidencias y grabar el video | Revisión mutua y sustentación |

### 11.1 Commits obligatorios

Cada integrante debe realizar como mínimo **dos commits propios durante el Sprint 1**, usando su propia cuenta de GitHub. Los mensajes deben describir el cambio que realmente subió cada persona.

| Integrante | Primer commit sugerido | Segundo commit sugerido | Cantidad exigida |
|---|---|---|---:|
| Luisa Fernanda Ortega | `Documenta particionado e instalación de Kubuntu` | `Agrega pruebas y evidencias de la VM gráfica` | 2 commits |
| Darío Montilla Narváez | `Documenta instalación y particionado de Debian` | `Agrega configuración de red y pruebas SSH` | 2 commits |

Los mensajes son ejemplos y se deben adaptar a los archivos que cada persona suba realmente. Luisa debe aceptar la invitación al repositorio y utilizar su propia cuenta para que GitHub atribuya correctamente sus commits.

## 12. Criterios de aceptación del Sprint 1

| N.º | Requisito solicitado | Configuración / evidencia con la que se demuestra |
|---:|---|---|
| 1 | VM `g01-grafica` con Kubuntu | Nombre de la VM en VirtualBox y versión en `/etc/os-release` |
| 2 | Particionado manual Kubuntu | `/`, `swap` y `/home`, demostrados con `lsblk -f` y `findmnt` |
| 3 | Dos navegadores en Kubuntu | Firefox y Falkon instalados y abiertos |
| 4 | Dos editores en Kubuntu | Kate y Geany instalados y abiertos |
| 5 | VM `g01-consola` con Debian | Nombre de la VM y salida de `/etc/os-release` |
| 6 | Debian con 25 GB y 2 CPU | Configuración de almacenamiento y sistema en VirtualBox |
| 7 | Particionado manual Debian | `/`, `swap`, `/home` y `/var`, demostrados con `lsblk -f` y `findmnt` |
| 8 | Herramientas de consola | `make`, `rsync`, `curl`, `git` y `wget` instalados; versiones verificadas |
| 9 | NAT en adaptador 1 de ambas VM | Configuración de red de VirtualBox |
| 10 | Mismo Host-only en adaptador 2 | Nombre de la red privada igual en ambas VM |
| 11 | Ping Kubuntu → Debian | Respuesta de `192.168.56.20` |
| 12 | SSH Kubuntu → Debian | Sesión remota funcional con el usuario de Debian |
| 13 | Instantánea Kubuntu | Snapshot llamado `instalacion-limpia` |
| 14 | Instantánea Debian | Snapshot llamado `instalacion-limpia` |
| 15 | Archivo del código Sprint 1 en ambas VM | `cat ~/codigo_sprint1.txt` y `date` muestran el texto oficial |
| 16 | Página con cinco puntos documentados | Cinco apartados, una captura por punto y comandos |
| 17 | Video continuo de tres minutos | Video con ambos integrantes visibles |
| 18 | Commits individuales | Dos commits propios de Luisa y dos de Darío dentro del sprint |

## 13. Diagnóstico de resultados: qué debe ocurrir y cómo corregirlo

| Prueba | Resultado correcto | Si no se cumple, revisar |
|---|---|---|
| Kubuntu inicia | Se muestra el escritorio y el sistema permite iniciar sesión | ISO, memoria RAM, orden de arranque y espacio del disco |
| Debian inicia | Se llega a una consola y se puede iniciar sesión | ISO, disco, CPU y configuración del arranque |
| Particiones | `lsblk -f` muestra los puntos de montaje y el swap activo | Asignación de puntos de montaje en el instalador; formato y partición swap |
| NAT | La VM puede resolver nombres y acceder a Internet | Adaptador 1 habilitado como NAT, conexión del anfitrión y DNS |
| Host-only | Ambas VM tienen direcciones de la misma subred privada | Adaptador 2, red Host-only compartida, máscara e IP duplicada |
| Ping entre VM | Hay respuestas desde `192.168.56.10` y `192.168.56.20` | IP, máscara, conexión al mismo Host-only y reglas de firewall |
| Servicio SSH | `systemctl is-active ssh` devuelve `active` | Paquete `openssh-server`, servicio habilitado y puerto TCP 22 |
| Conexión SSH | La terminal de Kubuntu entra a Debian | IP de destino, nombre de usuario, servicio activo, firewall y conectividad |
| Instantáneas | Cada VM muestra una instantánea con el nombre exacto | Selección de VM y escritura del nombre antes de guardar |

Para documentar cualquier incidencia, escribe el mensaje exacto del sistema, el comando que lo produjo, el ajuste realizado y el resultado de volver a ejecutar la prueba. No marques una prueba como aprobada solo por haber seguido los pasos.

## 14. Conclusión técnica del montaje propuesto

El diseño del Sprint 1 define dos máquinas virtuales independientes y conectadas: Kubuntu para las actividades gráficas y Debian para la administración por consola. La configuración de Debian respeta los 25 GB y las 2 CPU solicitadas; el diseño incluye el particionado manual requerido, los dos navegadores y dos editores de Kubuntu, las herramientas de Debian y un esquema de red con NAT más Host-only. Las direcciones privadas sugeridas son `192.168.56.10/24` para Kubuntu y `192.168.56.20/24` para Debian. El montaje se considerará técnicamente aceptado cuando ambas VM arranquen, las particiones se verifiquen con `lsblk` y `findmnt`, la comunicación funcione mediante ping y SSH y existan las dos instantáneas llamadas `instalacion-limpia`.

---

## Referencia de la consigna

Presentación **Proyecto Final — Dos máquinas virtuales, Docker y Kubernetes**, Sistemas Operativos 750001C, Universidad del Valle, semestre 2026-2:
- Página 3: cronograma y fecha de cierre del Sprint 1.
- Página 4: entregables del Sprint 1.
- Página 5: Kubuntu, Debian, particiones, herramientas, NAT, Host-only, ping, SSH e instantáneas.
- Página 10: requisitos de capturas, video, código del sprint y commits.
- Página 11: asignación de distribuciones del Grupo 1.

## Fuentes técnicas oficiales para las versiones y la red

- Kubuntu, descargas oficiales y soporte de Kubuntu 26.04 LTS: https://kubuntu.org/download/
- Debian, publicación oficial de Debian 13.8 (21 de noviembre de 2026): https://www.debian.org/News/2026/20261121
- Oracle VirtualBox 7.2, documentación de redes Host-only y servidor DHCP: https://docs.oracle.com/en/virtualization/virtualbox/7.2/user/networkingdetails.html

