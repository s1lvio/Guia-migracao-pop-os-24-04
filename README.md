# 🚀 Guia de Instalação e Migração: Pop!_OS 24.04 LTS (Ambiente COSMIC)

Este repositório documenta o processo de migração do **Zorin OS** para o **Pop!_OS 24.04 LTS**, detalhando o reaproveitamento da partição `/home` e a resolução de problemas de inicialização gráfica relacionados aos drivers da NVIDIA e ao ambiente COSMIC.

---

## 📋 1. Preparação Pré-Instalação

O objetivo desta instalação foi manter os arquivos pessoais intactos reutilizando o disco/partição `/home` da instalação anterior (Zorin OS), instalando o novo sistema em um disco separado.

* **Limpeza de Configurações Antigas:** Antes de iniciar a instalação do Pop!_OS, foram removidos os arquivos ocultos de configuração (dotfiles) referentes a aplicações antigas e ao ambiente **GNOME** presentes na `/home`. Isso evita conflitos visuais e de sistema com o novo ambiente gráfico **COSMIC**.

---

## 💿 2. Processo de Instalação e Particionamento

Durante a etapa de particionamento personalizado na instalação do Pop!_OS:

1. **Raiz do Sistema (`/`):** Selecionado um disco (HD/SSD) dedicado para o sistema operacional.
2. **Diretório Pessoal (`/home`):** Selecionado o disco/partição já existente do antigo Zorin OS (sem formatar, apenas definindo o ponto de montagem como `/home`).

> **Resultado:** Após a conclusão da instalação e reinicialização do sistema, todos os arquivos pessoais da pasta `/home` foram devidamente preservados e reconhecidos pelo Pop!_OS.

---

## 🛠️ 3. Troubleshooting: Tela Preta e Falha na Interface Gráfica

### O Problema
Após a instalação, em algumas inicializações, o sistema não carregava a interface gráfica automaticamente, permanecendo em uma **tela preta**.

* **Solução de contorno temporária:** Pressionar `Ctrl + Alt + F4` para acessar o terminal (TTY), realizar o login e iniciar o ambiente manualmente executando:
  ```bash
  #!/bin/bash
  start-cosmic
  ```

### A Solução Definitiva
Para corrigir o problema de forma permanente, foi necessário reconfigurar os drivers de vídeo da NVIDIA e reinstalar os pacotes principais do ambiente COSMIC.

#### Passo 1: Atualizar repositórios e corrigir dependências
```bash
#!/bin/bash
sudo apt update
sudo dpkg --configure -a
sudo apt install -f
```

#### Passo 2: Remover drivers NVIDIA antigos/conflitantes
```bash
#!/bin/bash
sudo apt purge --autoremove '*nvidia*' '*cuda*'
```

#### Passo 3: Limpar o cache local de pacotes
```bash
#!/bin/bash
sudo apt clean
```

#### Passo 4: Instalar o driver NVIDIA oficial homologado pelo Pop!_OS
```bash
#!/bin/bash
sudo apt install system76-driver-nvidia
```

#### Passo 5: Reinstalar o ambiente gráfico COSMIC
```bash
#!/bin/bash
sudo apt install --reinstall pop-desktop cosmic-session cosmic-greeter
```

#### Passo 6: Garantir a inicialização automática do gerenciador de login
```bash
#!/bin/bash
sudo systemctl enable cosmic-greeter
```

Após executar todos os passos acima, reinicie o computador (`sudo reboot`). O sistema deverá iniciar diretamente na tela de login gráfica do COSMIC.

## ⚡ Execução Automatizada via Script

Para facilitar o processo de correção do ambiente COSMIC e dos drivers da NVIDIA, você pode utilizar o script `fix_cosmic_nvidia.sh` presente neste repositório, que automatiza todas as etapas da solução definitiva.

### Como executar o script no Pop!\_OS

1. **Acesse o terminal:** Abra o terminal na pasta onde o arquivo `fix_cosmic_nvidia.sh` foi salvo (ou acesse o modo texto via `Ctrl + Alt + F4` caso esteja na tela preta e navegue até o diretório do arquivo).
2. **Conceda permissão de execução ao arquivo:**
   ```bash
   chmod +x fix_cosmic_nvidia.sh
   ```
3. **Execute o script:**
   ```bash
   ./fix_cosmic_nvidia.sh
   ```
4. **Reinicie o sistema:** Após a conclusão de todas as etapas, reinicie o computador para aplicar as alterações:
   ```bash
   sudo reboot
   ```
   
