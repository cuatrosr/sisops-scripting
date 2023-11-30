#!/bin/bash

# Función para verificar la existencia de un usuario
check_user_existence() {
    local username=$1
    id "$username" >/dev/null 2>"$1"
    return $?
}

echo "Uso de cpu de un usuario"

# Solictar nombre del usuario
read -r -p "Ingrese el nombre de usuario: " nombre_usuario

# Verificar si el usuario existe
if check_user_existence "$username"; then
    ps -e -o user,pcpu --sort -pcpu | awk '!/^USER/ {arr[$1]+=$2} END {for (i in arr) printf("Usuario: %-10s Uso de CPU: %.2f%%\n", i, arr[i])}' | grep "$nombre_usuario"
else
    echo "El usuario $username no existe."
fi
