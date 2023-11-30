#!/bin/bash

echo "Creando un usuario"

while true; do
    read -p "Ingrese el nombre de usuario: " username
    read -p "Ingrese el nombre completo del usuario: " full_name

    # Crear el usuario
    useradd_output=$(sudo useradd -m -c "$full_name" "$username" 2>&1)

    # Verificar si hubo un error al ejecutar useradd
    if echo "$useradd_output" | grep -q "useradd"; then
        echo "Intentalo de nuevo, $useradd_output"
    else
        # Asignarle una contraseña
		while true; do

			# Deshabilitar la impresión de caracteres
			stty -echo

			read -p "Ingrese una contraseña para el usuario: " password
			echo
			read -p "Confirme la contraseña: " password_confirm
			echo

			if [ "$password" = "$password_confirm" ]; then
				# Habilitar la impresión de caracteres
				stty echo 
				chpasswd_output=$(echo "$username:$password" | sudo chpasswd 2>&1)

				# Verificar si hubo un error al ejecutar chpasswd
				if echo "$chpasswd_output" | grep -q "CONTRASEÑA INCORRECTA"; then
				  echo "Intentalo de nuevo, $chpasswd_output "
				else
				  # Obtener el UID del usuario creado
				  uid=$(id -u "$username")
				  echo "Usuario creado exitosamente: $username"
				  echo
				  # Guardar la información del usuario en la BD
				  echo "$uid | $username | $full_name | habilitado" >> usersBD.txt
				  break
				fi
			else
				echo "Las contraseñas no coinciden. Por favor, inténtelo de nuevo."
			fi
		done
        break  
    fi
done
