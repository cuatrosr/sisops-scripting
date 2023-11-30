#!/bin/bash

echo "Actualizar grupo"

# Solicitar nombre del grupo
read -p "Ingrese el nombre del grupo: " group_name

# Busca el grupo en la BD
group_info=$(grep -i "| $group_name |" departmentsBD.txt)

if [ -z "$group_info" ]; then
    echo "No existe el grupo $group_name."
    echo
else
    read -p "Ingrese el nuevo nombre del grupo: " new_group_name
    sudo groupmod -n "$new_group_name" "$group_name"

    group_info_modified=$(echo "$group_info" | awk -F"|" -v new_group_name="$new_group_name" '{$2=" '$new_group_name' "} 1' OFS="|")
    sed -i "s~$group_info~$group_info_modified~" departmentsBD.txt

    echo "Nombre actualizado correctamente para el grupo $group_name."
    echo
fi
