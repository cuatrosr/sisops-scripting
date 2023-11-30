#!/bin/bash

enter_username() {
	read -p "Ingrese el nombre del usuario: " username

	# Buscar y obtener la info del usuario de la BD
	user_info=$(grep -i "| $username |" usersBD.txt)

	# Verificar si el usuario existe
	if [ -z "$user_info" ]; then
		echo "El usuario $username no existe en la BD."
		return 1 # Indica que el usuario no existe
	fi

	return 0 # Indica que el usuario existe
}

while true; do
	echo "Actualizando un usuario"
	echo "1. Actualizar el nombre completo de un usuario"
	echo "2. Actualizar la contraseña de un usuario"
	echo "0. Regresar"

	read -p "Seleccione una opción: " choice
	echo

	case $choice in

	1)
		enter_username
		if [ $? -eq 0 ]; then
			read -p "Ingrese el nuevo nombre completo: " new_full_name

			# Actualizar el nombre completo del usuario
			# en el sistema
			sudo usermod -c "$new_full_name" "$username"
			# en la BD
			user_info_modified=$(echo "$user_info" | awk -F"|" -v new_full_name="$new_full_name" '{$3=" '$new_full_name' "} 1' OFS="|")
			sed -i "s~$user_info~$user_info_modified~" usersBD.txt

			echo "Nombre completo actualizado correctamente para el usuario $username."
			echo
		fi
		;;

	2)
		enter_username
		if [ $? -eq 0 ]; then
			while true; do
				# Deshabilitar la impresión de caracteres
				stty -echo

				read -p "Ingrese la nueva contraseña: " password
				echo
				read -p "Confirme la nueva contraseña: " password_confirm
				echo

				if [ "$password" = "$password_confirm" ]; then

					# Habilitar la impresión de caracteres
					stty echo

					chpasswd_output=$(echo "$username:$password" | sudo chpasswd 2>&1)

					# Verificar si hubo un error al ejecutar chpasswd
					if echo "$chpasswd_output" | grep -q "CONTRASEÑA INCORRECTA"; then

						echo "Intentalo de nuevo, $chpasswd_output "
					else

						echo "Contraseña actualizada correctamente para el usuario $username."
						echo
						break
					fi

				else

					echo "Las contraseñas no coinciden. Por favor, inténtelo de nuevo."
				fi
			done
		fi
		;;

	0)
		echo "Volviendo al menu de gestion de usuarios."
		echo
		break
		;;

	*)
		echo "Opción no válida."
		;;
	esac
done
