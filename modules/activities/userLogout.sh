#!/bin/bash

echo "Cierres de sesion de un usuario"

# Solictar nombre del usuario
read -r -p "Ingrese el nombre de usuario: " nombre_usuario

journalctl | grep "session closed" | grep "$nombre_usuario"
