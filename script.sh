#!/bin/bash

# Menú principal
while true; do
    echo "1. Gestión de usuarios"
    echo "2. Gestión de departamentos"
    echo "3. Gestión de asosiaciones"
    echo "4. Gestión de logs"
    echo "5. Gestión de actividades en el sistema"
    echo "6. Gestión del sistema"
    echo "0. Salir"

    read -r -p "Seleccione una opción: " opcion

    case $opcion in
    1)
        # Menú de gestión de usuarios
        sh modules/users.sh
        ;;
    2)
        # Menú de gestión de departamentos
        sh modules/departments.sh
        ;;
    3)
        # Menú de asignación y desasignación de usuarios a departamentos
        sh modules/asosiations.sh
        ;;
    4)
        # Menú de gestión de logs
        sh modules/logs.sh
        ;;
    5)
        # Menú de gestión de actividades en el sistema
        sh modules/activities.sh
        ;;
    6)
        # Menú de gestión del sistema
        sh modules/system.sh
        ;;
    0)
        # Finalizar Script
        echo "Saliendo..."
        exit 0
        ;;
    *)
        # Opción no valida
        echo "Opción no válida"
        ;;
    esac
done
