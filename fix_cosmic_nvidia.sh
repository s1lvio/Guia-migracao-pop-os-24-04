#!/bin/bash

# Script de correção permanente para o ambiente COSMIC e driver NVIDIA no Pop!_OS 24.04 LTS
# Encerra a execução caso algum comando apresente falha crítica
set -e

echo "=== [1/6] Atualizando a lista de pacotes e corrigindo dependências ==="
sudo apt update
sudo dpkg --configure -a
sudo apt install -f -y

echo "=== [2/6] Removendo instalações anteriores dos drivers NVIDIA e CUDA ==="
sudo apt purge --autoremove -y '*nvidia*' '*cuda*'

echo "=== [3/6] Limpando o cache local do APT ==="
sudo apt clean

echo "=== [4/6] Instalando o driver oficial NVIDIA homologado pelo Pop!_OS ==="
sudo apt install -y system76-driver-nvidia

echo "=== [5/6] Reinstalando os pacotes do ambiente gráfico COSMIC ==="
sudo apt install --reinstall -y pop-desktop cosmic-session cosmic-greeter

echo "=== [6/6] Habilitando o gerenciador de login (cosmic-greeter) na inicialização ==="
sudo systemctl enable cosmic-greeter

echo "=== Processo concluído! Recomenda-se reiniciar o sistema (sudo reboot). ==="
