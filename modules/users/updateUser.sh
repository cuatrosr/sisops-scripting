#!/bin/bash

while true; do
    echo "1. Actualizar el nombre completo de un usuario"
    echo "2. Actualizar la contraseña de un usuario"
    echo "3. Regresar"

    read -p "Seleccione una opción: " choice

    case $choice in
        1)
            read -p "Ingrese el nombre del usuario: " username

            # Buscar y obtener la info del usuario de la BD
            user_info=$(grep -i "| $username |" usersBD.txt)
            
            # Verificar si el usuario existe
            if [ -n "$user_info" ]; then
                read -p "Ingrese el nuevo nombre completo para el usuario $username: " new_full_name

                # Actualizar el nombre completo del usuario
                sudo usermod -c "$new_full_name" "$username"

                user_info_modified=$(echo "$user_info" | awk -F"|" '{$3=" $new_full_name"} 1' OFS="|")
                sed -i "s~$user_info~$user_info_modified~" usersBD.txt

                echo "Nombre completo actualizado correctamente para el usuario $username."
            else
                echo "El usuario $username no existe en la BD."
            fi
            ;;
        2)
            read -p "Ingrese el nombre del usuario: " username

            # Verificar si el usuario existe
            if id "$username" &>/dev/null; then
                # Cambiar la contraseña del usuario
                sudo passwd "$username"

                echo "Contraseña actualizada correctamente."
            else
                echo "El usuario $username no existe."
            fi
            ;;
        3)
            echo "Volviendo al menu de gestion de usuarios."
            break
            ;;
        *)
            echo "Opción no válida."
            ;;
    esac
done

