#!/bin/bash

while true; do
    echo "Gestion de Logs"
    echo "1. Ver todos los inicios de sesion fallidos"
    echo "2. Ver todos los cambios de contraseña realizados"
    echo "3. Numero de veces que un determinado usuario inicio sesion"
    echo "4. Numero de veces que un determinado usuario cerro sesion"
    
    echo "0. Regresar al menú principal"

    read -r -p "Seleccione una opción: " opcion
    echo

    case $opcion in
    1)
        echo "Inicios de sesion fallidos"
        echo

        awk '/authentication failure/ {printf "Fecha: %s, Intento de autenticacion de parte del %s hacia el %s\n", $1, $7, $13}' /var/log/auth.log
        echo
        ;;

    2)
        echo "Cambios de contraseña realizados"
        grep "password changed" /var/log/auth.log | \
        sed -E 's/^([0-9]{4}-[0-9]{2}-[0-9]{2})T([0-9]{2}:[0-9]{2}:[0-9]{2}).*password changed for ([a-zA-Z0-9_-]+).*/Fecha: \1\nHora: \2\nMensaje: password changed for \3\n/' | \
        sed 's/T/ /'
        echo
        ;;
    3)
        echo "Numero de veces que un determinado usuario inicio sesion"
        echo
        read -r -p "Ingrese el nombre del usuario: " username
        count=$(awk -v user="$username" '$0 ~ user && /session opened/ {count++} END {print count}' /var/log/auth.log)

        if [ $count -gt 0 ]; then
            echo "El usuario $username ha tenido $count sesiones abiertas."
            echo
        else
            echo "No se encontraron sesiones abiertas para el usuario $username."
        fi
        ;;
        
    4)
        echo "Numero de veces que un determinado usuario cerro sesion"
        read -r -p "Ingrese el nombre del usuario: " user_name
        count=$(grep -c "session closed for user $user_name" /var/log/auth.log)
        echo "El usuario $user_name ha cerrado sesión $count veces."
        echo
        ;;
    0)
    	echo "Volviendo al menú principal..."
        break
	;;
    *)
        echo "Opción no válida"
        ;;
    esac
done
