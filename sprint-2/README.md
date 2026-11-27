# Sprint 2 · Servicios, seguridad, scripts, procesos y Docker

**Proyecto Final de Sistemas Operativos 750001C · Universidad del Valle · 2026-2**  
**Grupo 1:** Kubuntu en `g01-grafica` y Debian en `g01-consola`.

> Esta guía desarrolla los ocho requisitos de la página 6 de la presentación del proyecto. Los comandos son procedimientos para ejecutar en las máquinas virtuales; no constituyen evidencia de que ya se hayan ejecutado. Reemplacen los nombres de ejemplo por las cuentas reales del grupo y adjunten capturas originales de sus pruebas.

## 1. Usuarios, grupo y carpeta compartida

Realizar en **Debian (`g01-consola`)**. Crear una cuenta por integrante y un grupo común llamado `proyecto`. Ejemplo con nombres de usuario ilustrativos:

```bash
sudo adduser luisa
sudo adduser dario
sudo groupadd proyecto
sudo usermod -aG proyecto luisa
sudo usermod -aG proyecto dario
sudo mkdir -p /srv/proyecto
sudo chown root:proyecto /srv/proyecto
sudo chmod 2770 /srv/proyecto
getent group proyecto
ls -ld /srv/proyecto
id luisa
id dario
date
```

El bit setgid (`2`) hace que los archivos nuevos dentro de la carpeta hereden el grupo `proyecto`. Los integrantes deben cerrar e iniciar sesión para que se actualicen sus grupos.

**Verificación:** mostrar los dos usuarios, el grupo y los permisos de `/srv/proyecto`.

## 2. Sudo, chmod y chown

La consigna exige un usuario con sudo y otro sin sudo. En Debian, el usuario autorizado se agrega al grupo `sudo`; el otro no debe pertenecer a ese grupo.

```bash
sudo usermod -aG sudo dario
# No agregues a luisa al grupo sudo si será la cuenta sin privilegios.
groups dario
groups luisa
```

Después de cerrar sesión y volver a entrar, verificar con cada cuenta:

```bash
sudo -l
```

Práctica de permisos y propiedad:

```bash
sudo touch /srv/proyecto/prueba-permisos.txt
sudo chown dario:proyecto /srv/proyecto/prueba-permisos.txt
sudo chmod 660 /srv/proyecto/prueba-permisos.txt
ls -l /srv/proyecto/prueba-permisos.txt
date
```

El archivo queda legible y modificable por su propietario y por el grupo, sin permisos para otros usuarios. No se debe conceder sudo a la cuenta que la demostración identifica como usuario sin privilegios.

## 3. Firewall: SSH permitido y puerto 8080 cerrado/abierto

Antes de activar el firewall, confirmar que el servicio SSH esté instalado y activo para no perder el acceso remoto. En Debian:

```bash
sudo apt update
sudo apt install -y ufw
sudo systemctl enable --now ssh
sudo ufw allow OpenSSH
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable
sudo ufw status verbose
date
```

**Demostrar 8080 cerrado:** no crear una regla de permiso para ese puerto. Desde Kubuntu, intentar conectarse a `192.168.56.20:8080` cuando no haya una regla que lo permita. Para una prueba controlada, puede usarse `nc -vz -w 3 192.168.56.20 8080`; el resultado debe interpretarse junto con el estado del firewall y la ausencia de un servicio escuchando.

**Demostrar 8080 abierto:** crear temporalmente un servicio de prueba en Debian y permitir el puerto:

```bash
sudo ufw allow 8080/tcp
python3 -m http.server 8080 --bind 0.0.0.0
```

Dejar el servidor ejecutándose y, desde otra terminal en Kubuntu, probar:

```bash
curl -I http://192.168.56.20:8080
```

Al terminar, detener el servidor con `Ctrl+C`. Si el docente solicita dejar el puerto cerrado al finalizar:

```bash
sudo ufw delete allow 8080/tcp
sudo ufw status numbered
date
```

Sustituir la IP por la dirección Host-only real de Debian. No activar UFW sin haber permitido SSH.

## 4. Acceso SSH mediante llave y actualización del sistema

Ejecutar en **Kubuntu (`g01-grafica`)** como el usuario que realizará la conexión:

```bash
ssh-keygen -t ed25519 -C "grupo1-sistemas-operativos"
ssh-copy-id dario@192.168.56.20
ssh dario@192.168.56.20
```

Usar la cuenta real de Debian y su IP Host-only. En la sesión remota, comprobar:

```bash
whoami
hostname
date
```

La conexión debe completarse sin solicitar la contraseña de la cuenta remota (la llave puede tener una frase de protección si se configuró). Actualizar Debian:

```bash
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
date
```

No deshabilitar la autenticación por contraseña hasta verificar que el acceso por llave funciona correctamente.

## 5. Script gráfico Bash (Kubuntu)

El script debe incluir función, condicional, ciclo y comentarios, y ejecutarse desde un ícono del escritorio o del menú de aplicaciones. El archivo está en [`scripts/resumen-sistema.sh`](../scripts/resumen-sistema.sh).

```bash
chmod +x scripts/resumen-sistema.sh
./scripts/resumen-sistema.sh
```

Para crear un lanzador en KDE, crear un archivo llamado `Resumen del sistema.desktop` con este contenido:

```ini
[Desktop Entry]
Type=Application
Name=Resumen del sistema
Comment=Consulta información básica del equipo
Exec=konsole -e /bin/bash -lc '/RUTA/ABSOLUTA/Proyecto-final-S.O/scripts/resumen-sistema.sh'
Icon=utilities-system-monitor
Terminal=false
Categories=System;
```

Reemplazar `/RUTA/ABSOLUTA/` por la ubicación real del repositorio. Luego:

```bash
chmod +x "$HOME/Desktop/Resumen del sistema.desktop"
```

Si KDE muestra la opción de confianza o «Permitir lanzar», habilitarla. Abrir el script haciendo doble clic en el ícono; esa ejecución visual es la evidencia requerida.

## 6. Script de consola con argumento, validaciones y códigos de salida

El archivo [`scripts/contar-archivos.sh`](../scripts/contar-archivos.sh) recibe una ruta, valida el argumento y cuenta los archivos regulares del primer nivel del directorio.

```bash
chmod +x scripts/contar-archivos.sh

# Caso correcto: debe terminar con código 0
./scripts/contar-archivos.sh /srv/proyecto
echo $?

# Directorio inexistente: código 1
./scripts/contar-archivos.sh /ruta/no-existe
echo $?

# Argumento ausente: código 2
./scripts/contar-archivos.sh
echo $?
date
```

Códigos implementados: `0` ejecución correcta, `1` directorio inexistente, `2` cantidad incorrecta de argumentos y `3` directorio sin permiso de lectura. El código debe consultarse inmediatamente después de ejecutar el script.

## 7. Procesos: ps, top, kill, nice, renice y estados R/S/T/Z

En Debian, consultar procesos y sus estados:

```bash
ps -eo pid,ppid,stat,ni,comm --sort=pid
top
```

| Estado | Significado | Ejemplo o explicación |
|---|---|---|
| R | Ejecutándose o listo para ejecutarse | Proceso que está usando CPU o espera turno |
| S | Espera interrumpible | `sleep 300` |
| T | Detenido o bajo seguimiento | Proceso suspendido con `Ctrl+Z` |
| Z | Zombie | Proceso hijo que terminó y cuyo padre aún no recogió su estado |

Crear procesos de prueba y administrar su prioridad:

```bash
sleep 300 &
PID=$!
ps -o pid,stat,ni,comm -p "$PID"

nice -n 10 sleep 300 &
PID_NICE=$!
ps -o pid,stat,ni,comm -p "$PID_NICE"
renice 15 -p "$PID_NICE"
ps -o pid,stat,ni,comm -p "$PID_NICE"

kill "$PID" "$PID_NICE"
wait "$PID" "$PID_NICE" 2>/dev/null || true
date
```

Para observar T, ejecutar `sleep 300` en primer plano, pulsar `Ctrl+Z`, consultar `jobs -l` y revisar su estado con `ps`. Después reanudarlo con `fg` y detenerlo con `Ctrl+C`.

Para observar Z en un laboratorio controlado, se puede usar Python si está instalado. El proceso padre crea un hijo, este termina y el padre espera cinco segundos antes de recogerlo:

```bash
python3 -c 'import os,time; p=os.fork(); (os._exit(0) if p==0 else None); time.sleep(5); os.system("ps -o pid,ppid,stat,comm -p "+str(p)); os.waitpid(p,0)'
```

Durante esos cinco segundos, el hijo puede aparecer con estado Z. La ventana es breve: si no se alcanza a capturar, repetir la prueba. No matar procesos del sistema ni fabricar estados zombie dejando procesos abandonados.

## 8. Docker Engine y hello-world

En Debian, instalar el paquete disponible en los repositorios de la distribución:

```bash
sudo apt update
sudo apt install -y docker.io
sudo systemctl enable --now docker
sudo systemctl status docker --no-pager
sudo docker version
sudo docker run hello-world
sudo docker images
date
```

La consigna indica agregar el usuario al grupo `docker` y cerrar la sesión antes de probar sin `sudo`:

```bash
sudo usermod -aG docker "$USER"
```

Cerrar completamente la sesión del usuario y volver a entrar. Después:

```bash
groups
docker run hello-world
```

**Nota de seguridad:** el grupo `docker` concede privilegios equivalentes a root sobre el host. Agregar solamente la cuenta que administrará contenedores y explicar esta implicación en la sustentación.

## Evidencias y entrega

La presentación del proyecto establece para Sprint 2: **una página con ocho puntos, capturas, comandos y video de cuatro minutos; los dos scripts deben estar en el repositorio y cada integrante debe realizar al menos dos commits durante el sprint.**

### Capturas exigidas

Cada captura debe ser original, sin recortes ni ediciones, mostrar el prompt y el comando `date`; se pueden agrupar varios comandos si se leen completos.

1. Usuarios, grupo `proyecto` y carpeta `/srv/proyecto`.
2. Usuario con sudo, usuario sin sudo, `chmod` y `chown`.
3. Firewall: SSH permitido y puerto 8080 cerrado y luego abierto.
4. Acceso SSH por llave sin contraseña y actualización del sistema.
5. Script gráfico ejecutado desde el ícono en Kubuntu.
6. Script de consola con caso correcto, errores y códigos de salida.
7. Procesos y comandos solicitados; estados R, S, T y Z explicados y evidenciados.
8. Docker Engine instalado y salida de `hello-world`.

### Video

- Duración: **4 minutos**.
- Grabación continua de pantalla.
- Deben aparecer todos los integrantes, con su cara.
- Mostrar las pruebas y explicar brevemente los resultados.

### Commits individuales

Cada integrante debe realizar **dos commits propios como mínimo** durante el Sprint 2, desde su cuenta de GitHub y con mensajes que describan los cambios. Los commits hechos por una sola cuenta no sustituyen la participación individual del otro integrante.

### Código oficial del sprint

El docente publica el código 48 horas antes. Guardar la cadena oficial, sin inventarla, en `codigo_sprint2.txt` en ambas máquinas virtuales. Mostrarlo con:

```bash
cat ~/codigo_sprint2.txt
date
```

### Estructura sugerida de evidencias

```text
sprint-2/
├── README.md
└── evidencias/
    ├── 01-usuarios-grupo.png
    ├── 02-permisos-sudo.png
    ├── 03-firewall-8080.png
    ├── 04-ssh-llaves.png
    ├── 05-script-grafico.png
    ├── 06-script-consola.png
    ├── 07-procesos-estados.png
    └── 08-docker-hello-world.png

scripts/
├── resumen-sistema.sh
└── contar-archivos.sh
```

## Lista de verificación

- [ ] Dos cuentas creadas y grupo `proyecto` configurado.
- [ ] Carpeta `/srv/proyecto` con grupo y permisos adecuados.
- [ ] Un usuario con sudo y otro sin sudo; `chmod` y `chown` demostrados.
- [ ] Firewall activo, SSH permitido y puerto 8080 probado cerrado/abierto.
- [ ] Acceso SSH mediante llave y sistema actualizado.
- [ ] Script gráfico probado desde el ícono de Kubuntu.
- [ ] Script de consola probado con argumentos válidos e inválidos.
- [ ] Comandos de procesos y estados R, S, T y Z demostrados.
- [ ] Docker Engine instalado y `hello-world` funcionando.
- [ ] Ocho capturas originales incorporadas.
- [ ] Video continuo de cuatro minutos grabado.
- [ ] Dos commits propios de cada integrante.
- [ ] Código oficial guardado en ambas VMs.

## Fuentes técnicas

- [Documentación Debian](https://www.debian.org/doc/)
- [Manual de UFW](https://manpages.ubuntu.com/manpages/jammy/en/man8/ufw.8.html)
- [Manual de OpenSSH](https://www.openssh.com/manual.html)
- [Manual GNU Bash](https://www.gnu.org/software/bash/manual/)
- [Documentación Docker Engine](https://docs.docker.com/engine/install/debian/)

## Declaración de uso de IA

Se utilizó una herramienta de IA como apoyo para organizar la documentación y proponer ejemplos de comandos y scripts. El equipo debe revisar, comprender y adaptar el material, ejecutar las pruebas en sus propias máquinas, registrar errores y soluciones, y producir de manera auténtica las capturas y el video. La IA no sustituye las evidencias ni la participación individual.
