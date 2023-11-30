#!/bin/bash

# Función para verificar la existencia de un usuario
check_user_existence() {
    local username=$1
    id "$username" >/dev/null 2>"$1"
    return $?
}

echo "Consumo de memoria de un usuario"

# Solictar nombre del usuario
read -r -p "Ingrese el nombre de usuario: " nombre_usuario

if check_user_existence "$username"; then
    ps hax -o user:20,rssize --sort=-rssize | awk '{arr[$1]+=$2} END {for (i in arr) print "Usuario:", i, "Consumo de memoria total:", arr[i], "KB"}' | grep "$nombre_usuario"
else
    echo "El usuario $username no existe."
fi
