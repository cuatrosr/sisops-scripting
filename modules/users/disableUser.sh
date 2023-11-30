#!/bin/bash

echo "Deshabilitando un usuario"

# Solicitar el nombre de usuario
read -r -p "Ingrese el nombre de usuario: " username

# Buscar y obtener la info del usuario de la BD
user_info=$(grep -i "| $username |" usersBD.txt)

# Verificar si el usuario existe
if [ -n "$user_info" ]; then
    # Obtener el UID del usuario
    uid=$(echo "$user_info" | cut -d"|" -f1 | tr -d ' ')

    # Eliminar el usuario
    delete_output=$(sudo userdel -r "$username" 2>&1)

    # Cambiar el estado del usuario a deshabilitado
    user_info_modified=$(echo "$user_info" | awk -F"|" '{$4=" deshabilitado"} 1' OFS="|")
    sed -i "s~$user_info~$user_info_modified~" usersBD.txt
    echo "El usuario $username fue deshabilitado correctamente."
    echo
else
    echo "El usuario $username no fue encontrado en la BD, inténtalo de nuevo."
    echo
fi
