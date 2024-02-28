#!/bin/bash

# Detener NGINX y NGROK
sudo systemctl stop nginx.service
pkill ngrok

# Directorio de la repo
repo_dir="/var/www/NginxVM"

# Verificar si el directorio ya existe
if [ -d "$repo_dir" ]; then
    cd "$repo_dir"
    git pull
else
    git clone git@github.com:CL-Nayib/NginxVM.git "$repo_dir"
fi

# Iniciar NGINX
sudo systemctl start nginx

# Generar URL de NGROK
ngrok http 80 > /dev/null & 
# Esperar unos segundos para que NGROK se inicie
sleep 5

# Obtener la URL de NGROK
ngrok_url=$(curl -s http://localhost:4040/api/tunnels | jq -r .tunnels[0].public_url)

# Desplegar la URL de NGROK
echo "La URL de NGROK es: $ngrok_url"
