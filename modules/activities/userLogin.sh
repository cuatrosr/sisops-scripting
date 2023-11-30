#!/bin/bash

echo "Inicios de sesión de un usuario"

# Solictar nombre del usuario
read -r -p "Ingrese el nombre de usuario: " nombre_usuario

journalctl | grep "session opened" | grep "$nombre_usuario"
