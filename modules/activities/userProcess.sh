#!/bin/bash

# Función para verificar la existencia de un usuario
check_user_existence() {
    local username=$1
    id "$username" >/dev/null 2>"$1"
    return $?
}

echo "Cantidad de procesos de un usuario"

# Solictar nombre del usuario
read -r -p "Ingrese el nombre de usuario: " nombre_usuario
echo

if check_user_existence "$nombre_usuario"; then
    ps -e -o user= | sort | uniq -c | awk '{print "Usuario:", $2, "Cantidad de procesos:", $1}' | grep "$nombre_usuario"
else
    echo "El usuario $nombre_usuario no existe."
fi

echo
