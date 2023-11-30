#!/bin/bash

while true; do
    echo "Gestion de Logs"
    echo "1. Ver los inicios de sesion fallidos"
    echo "2. Ver los cambios de contraseña realizados"
    echo "3. Numero de veces que el usuario inicio sesion"
    echo "4. Numero de veces que el usuario cerro sesion"
    
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
        sh modules/logs/passwordChanged.sh
        ;;
    3)
        echo "Numero de veces que el usuario inicio sesion"
        echo
        read -p "Ingrese el nombre del usuario: " username
        count=$(awk -v user="$username" '$0 ~ user && /session opened/ {count++} END {print count}' /var/log/auth.log)

        if [ $count -gt 0 ]; then
            echo "El usuario $username ha tenido $count sesiones abiertas."
            echo
        else
            echo "No se encontraron sesiones abiertas para el usuario $username."
        fi
        ;;
        
    4)
        sh modules/logs/closedSessions.sh
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
