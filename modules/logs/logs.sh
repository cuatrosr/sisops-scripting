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
        sh modules/logs/authFailure.sh
        ;;
    2)
        grep "password changed" /var/log/auth.log | \
        sed -E 's/^([0-9]{4}-[0-9]{2}-[0-9]{2})T([0-9]{2}:[0-9]{2}:[0-9]{2}).*password changed for ([a-zA-Z0-9_-]+).*/Fecha: \1\nHora: \2\nMensaje: password changed for \3\n/' | \
        sed 's/T/ /'
        echo
        ;;
    3)
        sh modules/logs/openedSessions.sh
        ;;
        
    4)
        read -r -p "Ingrese el nombre del usuario: " user_name
        count=$(grep -c "session closed for user $user_name" /var/log/auth.log)
        echo "El usuario $user_name ha cerrado sesión $count veces."

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
