#!/bin/bash

echo "Bienvenido a la gestión de departamentos"

while true; do
    echo "1. Crear un grupo"
    echo "2. Deshabilitar un grupo"
    echo "3. Modificar un grupo"
    echo "0. Regresar al menú principal"

    read -r -p "Seleccione una opción: " opcion

    case $opcion in
    1)
        sh modules/departments/createDepartment.sh
        break
        ;;
    2)
        sh modules/departments/disableDepartment.sh
        ;;
    3)
        sh modules/departments/updateDepartment.sh
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
