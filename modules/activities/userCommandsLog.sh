#!/bin/bash

# Función para verificar la existencia de un usuario
check_user_existence() {
    local username=$1
    id "$username" >/dev/null 2>"$1"
    return $?
}

echo "Historial de comandos de un usuario"

# Solictar nombre del usuario
read -r -p "Ingrese el nombre de usuario: " nombre_usuario
echo

# Verificar si el usuario existe
if check_user_existence "$nombre_usuario"; then
    less "/home/$nombre_usuario/.bash_history"
else
    echo "El usuario $nombre_usuario no existe."
fi

echo
