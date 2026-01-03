# Txt-mp3

Convertidor sencillo de texto a voz (TTS) usando **Python 3**, **gTTS** y **mplayer**.

Ahora toda la interacción se hace desde la **terminal**, sin necesidad de abrir un editor gráfico.

El flujo es:

1. Ejecutas un script en Bash que te muestra una interfaz sencilla en la terminal.
2. Escribes el texto directamente en la terminal.
3. Un script en Python usa gTTS para convertir ese texto a un archivo MP3.
4. El script reproduce automáticamente el MP3 generado.

## Archivos principales

- `text-voz.py`: script en Python que:
  - Lee el contenido de `uribepirobo.txt`.
  - Usa `gTTS` para convertir el texto a voz.
  - Guarda el resultado como `uribepirobo.mp3`.
- `texto-voz.sh`: script en Bash que:
  - Muestra una interfaz en la terminal.
  - Te pide que escribas el texto (entrada estándar) y lo guarda en `uribepirobo.txt`.
  - Ejecuta `python3 text-voz.py` (o `python` si no hay `python3`).
  - Reproduce `uribepirobo.mp3` con `mplayer`.
  - Permite repetir el proceso varias veces en un bucle.
- `install.sh`: script de instalación de dependencias.
- `uribepirobo.txt`: archivo donde se guarda el texto que vas a convertir.

## Requisitos

- Sistema GNU/Linux (probado en varias distros, incluyendo Arch/Manjaro y Debian/Ubuntu).
- Conexión a Internet (gTTS usa el servicio de Google Text-to-Speech).
- Python 3.
- `pip3`/`pip` para instalar paquetes de Python.
- `mplayer` para reproducir el audio.

## Instalación

1. Clonar el repositorio (si estás trabajando desde GitHub):

   ```bash
   git clone https://github.com/Noisk8/Txt-mp.git
   cd Txt-mp3
   ```

2. Dar permisos de ejecución al script de instalación:

   ```bash
   chmod +x install.sh
   ```

3. Ejecutar el script de instalación:

   ```bash
   ./install.sh
   ```

   Este script intentará instalar, según tu distro:

   - `python3` / `python`
   - `pip3` / `pip`
   - librería `gTTS` (en distros tipo Arch/Manjaro se instala con `--user`)
   - `mplayer`

   y dará permisos de ejecución a `texto-voz.sh`.

## Uso (interfaz en terminal)

1. Desde la carpeta del proyecto, ejecuta:

   ```bash
   ./texto-voz.sh
   ```

2. Verás un menú en la terminal parecido a:

   ```text
   ========================================
      TXT → MP3  (gTTS)
   ========================================
   Escribe el texto que quieres convertir a voz.
   Cuando termines, pulsa CTRL+D en una línea nueva.

   Introduce tu texto ahora:
   ```

3. Escribe libremente el texto que quieras (puede tener varias líneas). Cuando termines:

   - Pulsa `Enter` para ir a una nueva línea.
   - Luego pulsa `Ctrl + D` en una línea vacía para indicar que has terminado.

4. El script:

   - Guardará tu texto en `uribepirobo.txt`.
   - Llamará a `text-voz.py` para generar `uribepirobo.mp3` usando gTTS.
   - Reproducirá el audio con `mplayer`.

5. Después de reproducir, te preguntará:

   ```text
   ¿Quieres convertir otro texto? [s/N]:
   ```

   - Pulsa `s` o `si` (en minúsculas o mayúsculas) para repetir.
   - Cualquier otra tecla (o `Enter` vacío) para salir.

## Personalización

- **Cambiar el archivo de texto**:
  - Edita `texto-voz.sh` y `text-voz.py` y cambia `uribepirobo.txt` por otro nombre.
- **Cambiar el archivo de salida MP3**:
  - En `text-voz.py`, modifica `uribepirobo.mp3` por el nombre de archivo que quieras.
- **Cambiar el idioma de la voz**:
  - En `text-voz.py`, el idioma está en minúsculas (por ejemplo `"es"` para español):

    ```python
    tts("uribepirobo.txt", "es", "uribepirobo.mp3")
    ```

    Puedes cambiar `"es"` por cualquier idioma soportado por gTTS (`"en"`, `"fr"`, etc.).

## Ejemplo simplificado de la función TTS

```python
from gtts import gTTS


def tts(text_file, lang, name_file):
    with open(text_file, "r") as file:
        text = file.read()
    file = gTTS(text=text, lang=lang)
    file.save(name_file)


tts("uribepirobo.txt", "es", "uribepirobo.mp3")
```

## Notas

- El servicio de gTTS depende de la conexión a Internet: sin conexión, la conversión fallará.
- Si `mplayer` no está disponible en tu distribución, puedes sustituirlo por otro reproductor de línea de comandos (por ejemplo, `ffplay`) editando `texto-voz.sh`.
- El diseño está pensado para trabajar 100% en terminal, para poder usarlo incluso en sistemas sin entorno gráfico.
