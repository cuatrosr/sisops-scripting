#!/bin/bash

while true; do
    clear
    echo "Menú de Administración"
    echo "1. Mostrar archivos modificados por un usuario"
    echo "2. Ver historial de comandos de un usuario"
    echo "3. Ver inicios de sesión de un usuario"
    echo "4. Ver cierres de sesión de un usuario"
    echo "5. Ver historial de sesiones del sistema"
    echo "0. Regresar al menú principal"

    read -r -p "Seleccione una opción (1-6): " opcion
    echo

    case $opcion in
    1)
        sh modules/activities/userFilesModified.sh
        ;;
    2)
        sh modules/activities/userCommandsLog.sh
        ;;
    3)
        sh modules/activities/userLogin.sh
        ;;

    4)
        sh modules/activities/userLogout.sh
        ;;
    5)
        sh modules/activities/loginLogs.sh
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
