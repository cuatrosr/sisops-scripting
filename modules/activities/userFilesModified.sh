#!/bin/bash

# Función para verificar la existencia de un usuario
check_user_existence() {
    local username=$1
    id "$username" >/dev/null 2>"$1"
    return $?
}

echo "Archivos modificados por el usuario"

# Solictar ruta del directorio
read -r -p "Ingrese la ruta del directorio: " ruta_directorio

# Solictar nombre del usuario
read -r -p "Ingrese el nombre de usuario: " nombre_usuario
echo

# Verificar si el usuario existe
if check_user_existence "$nombre_usuario"; then
    find "$ruta_directorio" -type f -user "$nombre_usuario" -exec stat --format='%U %y %n' {} \; 2>/dev/null

else
    echo "El usuario $nombre_usuario no existe."
fi

echo
