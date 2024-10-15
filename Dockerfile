# Usa a imagem base do Ubuntu
FROM ubuntu:20.04

# Atualiza o sistema e instala Ansible
RUN apt-get update && apt-get install -y \
    software-properties-common \
    ansible \
    git \
    nano \
    && apt-get clean

# Define o diretório de trabalho
WORKDIR /ansible

# Copia os scripts Ansible para o contêiner
COPY . .

# Define o comando padrão
CMD ["bash"]

