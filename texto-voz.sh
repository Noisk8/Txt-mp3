#!/bin/bash

# Interfaz en terminal para convertir texto a voz con gTTS

TEXT_FILE="uribepirobo.txt"
OUTPUT_FILE="uribepirobo.mp3"

PYTHON_BIN="python3"
if ! command -v "$PYTHON_BIN" >/dev/null 2>&1; then
    PYTHON_BIN="python"
fi

while true; do
    echo "========================================"
    echo "   TXT → MP3  (gTTS)"
    echo "========================================"
    echo "Escribe el texto que quieres convertir a voz."
    echo "Cuando termines, pulsa CTRL+D en una línea nueva."
    echo

    # Leer texto desde la terminal y guardarlo en el archivo
    echo "Introduce tu texto ahora:"    
    cat > "$TEXT_FILE"

    echo
    echo "Generando audio en $OUTPUT_FILE ..."
    "$PYTHON_BIN" "$(dirname "$0")"/text-voz.py

    if [ -f "$OUTPUT_FILE" ]; then
        echo "Reproduciendo $OUTPUT_FILE ..."
        mplayer "$OUTPUT_FILE"
    else
        echo "No se encontró $OUTPUT_FILE. Algo falló en la generación de audio." >&2
    fi

    echo
    read -r -p "¿Quieres convertir otro texto? [s/N]: " again
    case "$again" in
        [sS] | [sS][iI])
            continue
            ;;
        *)
            echo "Saliendo."
            break
            ;;
    esac
done
