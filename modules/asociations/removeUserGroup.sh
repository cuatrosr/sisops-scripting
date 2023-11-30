#!/bin/bash

# Función para verificar la existencia de un usuario
check_user_existence() {
    local username=$1
    id "$username" >/dev/null 2>"$1"
    return $?
}

echo "Eliminar usuario de un grupo"

read -r -p "Introduce el nombre del usuario: " username
read -r -p "Introduce el nombre del grupo del que quieres eliminar al usuario: " groupname

# Verificar si el usuario existe
if check_user_existence "$username"; then
    # Verificar si el grupo existe
    if grep -q "^$groupname:" /etc/group; then
        # Eliminar usuario del grupo
        sudo deluser "$username" "$groupname"
        echo "El usuario $username ha sido eliminado del grupo $groupname."
        sed -i "/$username:$groupname/d" 'asociations.txt'
    else
        echo "El grupo $groupname no existe."
    fi
else
    echo "El usuario $username no existe."
fi
