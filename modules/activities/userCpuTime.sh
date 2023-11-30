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

echo "Tiempo dedicado a un proceso de la cpu de un usuario"

# Solictar nombre del usuario
read -r -p "Ingrese el nombre de usuario: " nombre_usuario

if check_user_existence "$username"; then
    ps -eo user,comm,%cpu --sort=-%cpu | awk '!/^USER/ {arr[$1]+=$3} END {for (i in arr) printf("Usuario: %-10s Tiempo de CPU: %.2f\n", i, arr[i])}' | grep "$nombre_usuario"
else
    echo "El usuario $username no existe."
fi
