# Xuper TV para Roku

Canal para Roku (BrightScript + SceneGraph) que usa el mismo servidor que la versión de Samsung.

**Créditos:** basado en el port de webOS de **CristianDev**, que autorizó su uso y modificación. Proyecto no oficial, sin relación con Xuper TV ni con Roku. No incluye contenido audiovisual.

## Cómo funciona

Roku no ejecuta HTML ni Node, así que la interfaz está reescrita desde cero y todo lo demás lo hace el servidor:

```
Roku (canal)  ──HTTP──▶  PC / Raspberry Pi (servidor de XuperTV-Samsung)  ──▶  portal
```

## 1. Servidor

Usa `server/` del repo **XuperTV-Samsung** (`./iniciar-servidor.sh`, necesita `nodejs` y `ffmpeg`). Debe estar en la misma red que el Roku.

## 2. Activar el modo desarrollador en el Roku

Con el mando: **Inicio ×3, Arriba ×2, Derecha, Izquierda, Derecha, Izquierda, Derecha**. Acepta, crea una clave y anota la IP.

## 3. Instalar el canal

```bash
sudo apt install zip curl
./instalar-roku.sh IP_DEL_ROKU CLAVE
```

O sube el zip a mano en `http://IP_DEL_ROKU` (usuario `rokudev`).

## 4. Primer uso

Al abrir el canal pide la dirección del servidor: `http://IP_DEL_PC:8910`. Se guarda en el Roku y se cambia desde el menú **Servidor**.

## Qué tiene

Películas, series con episodios, destacado, canales en vivo y buscador. Los videos `.ts` se piden al servidor como HLS virtual, y el "modo fluido" (`ffmpeg`) convierte a MP4.

## Estado

- Validado con el linter `brighterscript`, sin errores de sintaxis.
- **Sin probar en un Roku real.** Puede haber ajustes en el foco del mando, en los formatos de video (HEVC solo en modelos 4K) y en la reproducción en vivo.
