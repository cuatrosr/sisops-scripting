#!/bin/bash

echo "Deshabilitar grupo"
read -p "Ingrese el nombre del grupo: " group_name

group_info=$(grep -i "| $group_name |" departmentsBD.txt)

if [ -n "$group_info" ]; then
    # Obtener el UID del grupo
    gid=$(echo "$group_info" | cut -d"|" -f1 | tr -d ' ')

    # Eliminar el grupo
    delete_output=$(sudo groupdel -r "$group_name" 2>&1)

    # Cambiar el estado del grupo a deshabilitado
    group_info_modified=$(echo "$group_info" | awk -F"|" '{$3=" deshabilitado"} 1' OFS="|")
    sed -i "s~$group_info~$group_info_modified~" departmentsBD.txt
    echo "El grupo $group_name fue deshabilitado correctamente."
    echo
else
    echo "El grupo $group_name no fue encontrado en la BD, inténtalo de nuevo."
    echo
fi