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
        sh modules/logs/authFailure.sh
        ;;
    2)
        sh modules/logs/passwordChanged.sh
        ;;
    3)
        sh modules/logs/openedSessions.sh
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
