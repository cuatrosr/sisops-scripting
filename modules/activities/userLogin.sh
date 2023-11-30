#!/bin/bash

# Función para verificar la existencia de un usuario
check_user_existence() {
    local username=$1
    if id "$username" >/dev/null 2>&1; then
        return 0 # El usuario existe
    else
        return 1 # El usuario no existe
    fi
}

echo "Inicios de sesión de un usuario"

# Solictar nombre del usuario
read -r -p "Ingrese el nombre de usuario: " nombre_usuario

if check_user_existence "$username"; then
    journalctl | grep "session opened" | grep "$nombre_usuario"
else
    echo "El usuario $username no existe."
fi
