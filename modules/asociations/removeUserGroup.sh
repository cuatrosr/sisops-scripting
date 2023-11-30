#!/bin/bash

# Función para verificar la existencia de un usuario
check_user_existence() {
    local username=$1
    id "$username" >/dev/null 2>"$1"
    return $?
}

echo "Eliminar usuario de un grupo"

read -r -p "Introduce el nombre del usuario: " nombre_usuario
read -r -p "Introduce el nombre del grupo del que quieres eliminar al usuario: " groupname

# Verificar si el usuario existe
if check_user_existence "$nombre_usuario"; then
    # Verificar si el grupo existe
    if grep -q "^$groupname:" /etc/group; then
        # Eliminar usuario del grupo
        sudo deluser "$nombre_usuario" "$groupname"
        echo "El usuario $nombre_usuario ha sido eliminado del grupo $groupname."
        sed -i "s/$nombre_usuario:$groupname:ACTIVE/$nombre_usuario:$groupname:INACTIVE/g" 'asociations.txt'
    else
        echo "El grupo $groupname no existe."
    fi
else
    echo "El usuario $nombre_usuario no existe."
fi

echo
