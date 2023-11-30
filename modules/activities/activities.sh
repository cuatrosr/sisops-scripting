#!/bin/bash

while true; do
    echo "Menú de Administración"
    echo "1. Mostrar archivos modificados por un usuario"
    echo "2. Ver historial de comandos de un usuario"
    echo "3. Ver consumo de memoria de un usuario"
    echo "4. Ver uso de cpu de un usuario"
    echo "5. Ver tiempo dedicado a un proceso de la cpu de un usuario"
    echo "6. Ver cantidad de procesos de un usuario"
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
        sh modules/activities/userMemory.sh
        ;;

    4)
        sh modules/activities/userCpuUses.sh
        ;;
    5)
        sh modules/activities/userCpuTime.sh
        ;;
    6)
        sh modules/activities/userProcess.sh
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
