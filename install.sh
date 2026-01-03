#!/bin/bash

set -e

# Instalador para Txt-mp3 en Linux
# - En distros con pacman (Arch/Manjaro) NO se instala gTTS automáticamente
#   por las restricciones de PEP 668. Ahí se muestra cómo hacerlo con venv.

PKG_PLAYER=mplayer
PKG_EDITOR=gedit

have_cmd() {
    command -v "$1" >/dev/null 2>&1
}

install_apt() {
    echo "Detectado sistema basado en Debian/Ubuntu (apt)."
    sudo apt update
    sudo apt install -y python3 python3-pip "$PKG_PLAYER" "$PKG_EDITOR"
}

install_pacman() {
    echo "Detectado sistema basado en Arch/Manjaro (pacman)."
    sudo pacman -Sy --needed python python-pip "$PKG_PLAYER" "$PKG_EDITOR"
}

install_dnf() {
    echo "Detectado sistema basado en Fedora (dnf)."
    sudo dnf install -y python3 python3-pip "$PKG_PLAYER" "$PKG_EDITOR"
}

install_zypper() {
    echo "Detectado sistema basado en openSUSE (zypper)."
    sudo zypper install -y python3 python3-pip "$PKG_PLAYER" "$PKG_EDITOR"
}

install_pkg_manager_deps() {
    if have_cmd apt; then
        install_apt
    elif have_cmd apt-get; then
        install_apt
    elif have_cmd pacman; then
        install_pacman
    elif have_cmd dnf; then
        install_dnf
    elif have_cmd zypper; then
        install_zypper
    else
        echo "No se detectó un gestor de paquetes soportado (apt, pacman, dnf, zypper)." >&2
        echo "Instala manualmente: Python 3, pip para Python 3, mplayer y gedit." >&2
        exit 1
    fi
}

echo "=== Instalando dependencias del sistema (Python, mplayer, editor) ==="
install_pkg_manager_deps

PYTHON_BIN="python3"
if ! have_cmd "$PYTHON_BIN"; then
    PYTHON_BIN="python"
fi

if have_cmd pacman; then
    echo "=== NOTA para Arch/Manjaro ==="
    echo "Por PEP 668, este sistema no permite instalar paquetes Python de forma global con pip." >&2
    echo "Te recomiendo crear un entorno virtual local para este proyecto y dentro de él instalar gTTS:" >&2
    echo >&2
    echo "    cd \"$(pwd)\"" >&2
    echo "    $PYTHON_BIN -m venv .venv" >&2
    echo "    source .venv/bin/activate" >&2
    echo "    pip install gTTS" >&2
    echo >&2
    echo "Luego ejecuta: ./texto-voz.sh" >&2
else
    echo "=== Instalando gTTS con pip (sistemas no Arch/Manjaro) ==="
    if have_cmd pip3; then
        sudo pip3 install gTTS
    elif have_cmd pip; then
        sudo pip install gTTS
    else
        echo "No se encontró pip ni pip3. Instálalo manualmente y luego ejecuta: pip3 install gTTS" >&2
        exit 1
    fi
fi

chmod +x texto-voz.sh

echo "Instalación completada (dependencias de sistema)."
