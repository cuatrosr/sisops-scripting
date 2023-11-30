#!/bin/bash

# Función para verificar la existencia de un usuario
check_user_existence() {
    local username=$1
    if id "$username" 2>/dev/null; then
        return 0 # El usuario existe
    else
        return 1 # El usuario no existe
    fi
}

echo "Historial de comandos de un usuario"

# Solictar nombre del usuario
read -r -p "Ingrese el nombre de usuario: " nombre_usuario

# Verificar si el usuario existe
if check_user_existence "$username"; then
    less "/home/$nombre_usuario/.bash_history"
else
    echo "El usuario $username no existe."
fi
