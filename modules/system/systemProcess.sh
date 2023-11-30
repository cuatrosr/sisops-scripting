#!/bin/bash

# Límite de procesos permitidos
LIMIT=50

echo "Monitoreo de procesos activos con un limite de $LIMIT por usuario"
echo

# Obtener una lista de todos los usuarios únicos que tienen procesos
USERS=$(ps hax -o user | sort | uniq)

for USER in $USERS; do
    # Cantidad de procesos del usuario
    PROCESS_COUNT=$(ps -U "$USER" | wc -l)

    if [ "$PROCESS_COUNT" -gt "$LIMIT" ]; then
        echo "Alerta: El usuario $USER tiene $PROCESS_COUNT procesos, superando el límite de $LIMIT."
    fi
done

echo "Monitoreo terminado"
echo
