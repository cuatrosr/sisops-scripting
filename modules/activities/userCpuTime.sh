#!/bin/bash

# Función para verificar la existencia de un usuario
check_user_existence() {
    local username=$1
    id "$username" >/dev/null 2>"$1"
    return $?
}

echo "Tiempo dedicado a un proceso de la cpu de un usuario"

# Solictar nombre del usuario
read -r -p "Ingrese el nombre de usuario: " nombre_usuario

if check_user_existence "$nombre_usuario"; then
    ps -eo user,comm,%cpu --sort=-%cpu | awk '!/^USER/ {arr[$1]+=$3} END {for (i in arr) printf("Usuario: %-10s Tiempo de CPU: %.2f\n", i, arr[i])}' | grep "$nombre_usuario"
else
    echo "El usuario $nombre_usuario no existe."
fi
