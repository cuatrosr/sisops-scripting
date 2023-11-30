#!/bin/bash

while true; do
    echo "Menú de Asociaciones"
    echo "1. Añadir usuario a un grupo"
    echo "2. Eliminar un usuario de un grupo"
    echo "0. Regresar al menú principal"

    read -r -p "Seleccione una opción (1-2): " opcion
    echo

    case $opcion in
    1)
        sh modules/asociations/addUserGroup.sh
        ;;
    2)
        sh modules/asociations/removeUserGroup.sh
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
