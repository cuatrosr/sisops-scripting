#!/bin/bash

while true; do
    echo "Gestiona tus usuarios"
    echo "1. Crear un usuario"
    echo "2. Deshabilitar un usuario"
    echo "3. Modificar un usuario"
    echo "0. Regresar al menú principal"

    read -r -p "Seleccione una opción: " opcion
    echo

    case $opcion in
    1)
        sh modules/users/createUser.sh
        ;;
    2)
        sh modules/users/disableUser.sh
        ;;
    3)
        sh modules/users/updateUser.sh
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
