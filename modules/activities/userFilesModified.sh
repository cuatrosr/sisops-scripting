#!/bin/bash

# Función para verificar la existencia de un usuario
check_user_existence() {
    local username=$1
    if id "$username" 2>/dev/null; then
        return 0 # El usuario existe
    else
        return 1 # El usuario no existe
    fi
}

echo "Archivos modificados por el usuario"

# Solictar ruta del directorio
read -r -p "Ingrese la ruta del directorio: " ruta_directorio

# Solictar nombre del usuario
read -r -p "Ingrese el nombre de usuario: " nombre_usuario

# Verificar si el usuario existe
if check_user_existence "$username"; then
    find "$ruta_directorio" -type f -user "$nombre_usuario" -exec stat --format='%U %y %n' {} \; 2>/dev/null

else
    echo "El usuario $username no existe."
fi
