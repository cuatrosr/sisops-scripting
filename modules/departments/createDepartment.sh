#!/bin/bash

echo "Crear grupo"

# Solictar nombre del grupo
read -p "Ingrese el nombre del grupo: " group_name

# BUsca el grupo en el sistema
isInSystem=$(grep -c "$group_name" /etc/group)

if [ $isInSystem -eq 0 ]; then 
	sudo groupadd "$group_name"
	gid=$(getent group "$group_name" | awk -F: '{print $3}')
	echo "Grupo creado exitosamente: $group_name"
	echo
	echo "$gid | $group_name | habilitado">> departmentsBD.txt
else 
	echo "Ya existe un grupo con ese nombre, intentalo nuevamente"
fi
