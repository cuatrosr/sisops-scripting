#!/bin/bash

echo "Historial de comandos de un usuario"

# Solictar nombre del usuario
read -r -p "Ingrese el nombre de usuario: " nombre_usuario

less "/home/$nombre_usuario/.bash_history"
