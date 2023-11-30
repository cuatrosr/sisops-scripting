#!/bin/bash

# Función para verificar la existencia de un usuario
check_user_existence() {
    local username=$1
    id "$username" >/dev/null 2>"$1"
    return $?
}

echo "Añadir usuario a un grupo"

read -r -p "Introduce el nombre del usuario: " nombre_usuario
read -r -p "Introduce el nombre del grupo al que quieres añadir al usuario: " groupname

# Verificar si el usuario existe
if check_user_existence "$nombre_usuario"; then
    # Verificar si el grupo existe
    if grep -q "^$groupname:" /etc/group; then
        # Añadir usuario al grupo
        sudo usermod -aG "$groupname" "$nombre_usuario"
        echo "El usuario $nombre_usuario ha sido añadido al grupo $groupname."
        echo "$nombre_usuario:$groupname:ACTIVE" >>asociations.txt
    else
        echo "El grupo $groupname no existe."
    fi
else
    echo "El usuario $nombre_usuario no existe."
fi

echo
