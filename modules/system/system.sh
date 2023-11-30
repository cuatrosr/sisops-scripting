#!/bin/bash

while true; do
    echo "Menú de Monitoreo"
    echo "1. Monitorear procesos de los usuarios"
    echo "2. Monitorear uso de memoria de los usuarios"
    echo "3. Monitorear uso de la CPU de los usuarios"
    echo "0. Regresar al menú principal"

    read -r -p "Seleccione una opción (1-3): " opcion
    echo

    case $opcion in
    1)
        sh modules/system/systemProcess.sh
        ;;
    2)
        sh modules/system/systemMemory.sh
        ;;
    3)
        sh modules/system/systemCpu.sh
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
