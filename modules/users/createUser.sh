#!/bin/bash

read -p "Ingrese el nombre de usuario: " username
read -p "Ingrese el nombre completo del usuario: " full_name

while true; do

    # Deshabilitar la impresión de caracteres
    stty -echo
    
    read -p "Ingrese la contraseña: " password
    echo
    read -p "Confirme la contraseña: " password_confirm
    echo

    if [ "$password" = "$password_confirm" ]; then

       # Habilitar la impresión de caracteres
       stty echo 

       break

    else
        echo "Las contraseñas no coinciden. Por favor, inténtelo de nuevo."
    fi
done

# Crear el usuario
sudo useradd -m -c "$full_name" "$username"
# Establecerle la contraseña
echo "$username:$password" | sudo chpasswd
# Obtener el UID del usuario creado
uid=$(id -u "$username")
echo "Usuario creado exitosamente: $username"

# Guardar la información del usuario en la BD
echo "$uid | $username | $full_name" >> usersBD.txt
