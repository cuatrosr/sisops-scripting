#!/bin/bash

# Límite de uso de CPU permitido (%)
limit_info=$(grep -i "cpu" limit.txt)
LIMIT=$(echo "$limit_info" | awk -F":" '{print $2}')

echo "Monitoreo de uso de la CPU con un limite de $LIMIT por usuario"
echo

# Obtener una lista de todos los usuarios únicos que tienen procesos
USERS=$(ps hax -o user | sort | uniq)

for USER in $USERS; do
    # Uso de CPU del usuario
    CPU_USAGE=$(ps -U "$USER" -o pcpu= | awk '{sum+=$1} END {print sum}')

    # Eliminar el punto decimal para facilitar la comparación
    CPU_USAGE=${CPU_USAGE%.*}

    if [ "$CPU_USAGE" -gt "$LIMIT" ]; then
        echo "Alerta: El usuario $USER está utilizando $CPU_USAGE% de CPU, superando el límite de $LIMIT%."
    fi
done

echo "Monitoreo terminado"
echo
