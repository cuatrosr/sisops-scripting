#!/bin/bash

echo "Archivos modificados por el usuario"

# Solictar ruta del directorio
read -r -p "Ingrese la ruta del directorio: " ruta_directorio

# Solictar nombre del usuario
read -r -p "Ingrese el nombre de usuario: " nombre_usuario

find "$ruta_directorio" -type f -user "$nombre_usuario" -exec stat --format='%U %y %n' {} \; 2>/dev/null
