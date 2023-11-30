#!/bin/bash

# Límite de memoria permitido en KB
LIMIT=1000000

echo "Monitoreo de uso de memoria con un limite de $LIMIT KB por usuario"

# Obtener una lista de todos los usuarios únicos que tienen procesos
USERS=$(ps hax -o user | sort | uniq)

for USER in $USERS; do
    # Uso de memoria del usuario en KB
    MEMORY_USAGE=$(ps -U "$USER" -o rss= | awk '{sum+=$1} END {print sum}')

    if [ "$MEMORY_USAGE" -gt "$LIMIT" ]; then
        echo "Alerta: El usuario $USER está utilizando $MEMORY_USAGE KB de memoria, superando el límite de $LIMIT KB."
    fi
done

echo "Monitoreo terminado"
