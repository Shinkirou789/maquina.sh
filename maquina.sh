#!/bin/bash

AZUL="\033[34m"
VERDE="\033[32m"
ROJO="\033[31m"
RESET="\033[0m"

echo -e "${AZUL}"
cat << "EOF"
  _____   _   _   _____   _   _   _  __  _____   
 / ____| | | | | |_   _| | \ | | | |/ / |_   _|  
| (___   | |_| |   | |   |  \| | | ' /    | |    
 \___ \  |  _  |   | |   | . ` | |  <     | |    
 ____) | | | | |  _| |_  | |\  | | . \   _| |_   
|_____/  |_| |_| |_____| |_| \_| |_|\_\ |_____|  
EOF
echo -e "${RESET}"

archivo="$1"

archivo="${archivo,,}"

if [ -z "$archivo" ]; then
    echo -e "${ROJO}Error: no has indicado el nombre del archivo${RESET}"
    exit 1
fi

ruta_zip="/home/shinki/Descargas/${archivo}.zip"
ruta_destino="/home/shinki/Escritorio/maquina"

if [ ! -f "$ruta_zip" ]; then
    echo -e "${ROJO}Error: El archivo ZIP '$ruta_zip' no existe.${RESET}"
    exit 1
fi

# Extraer el archivo ZIP
unzip -o "$ruta_zip" -d "/home/shinki/Descargas/" || {
    echo -e "${ROJO}Error al descomprimir el archivo.${RESET}"
    exit 1
}

# Mover archivos si existen
[ -f "/home/shinki/Descargas/auto_deploy.sh" ] && mv "/home/shinki/Descargas/auto_deploy.sh" "$ruta_destino"
[ -f "/home/shinki/Descargas/${archivo}.tar" ] && mv "/home/shinki/Descargas/${archivo}.tar" "$ruta_destino"

# Eliminar el ZIP solo si la extracción fue exitosa
rm "$ruta_zip"

echo -e "${VERDE}Proceso realizado con éxito${RESET}"

sudo bash /home/shinki/Descargas/auto_deploy.sh /home/shinki/Descargas/${archivo}.tar