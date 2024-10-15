# Usa a imagem base do Ubuntu
FROM ubuntu:20.04

# Define o frontend do debconf como não interativo
ENV DEBIAN_FRONTEND=noninteractive

# Atualiza o sistema e instala Ansible, Git e Nano
RUN apt-get update && apt-get install -y \
    software-properties-common \
    ansible \
    git \
    nano \
    tzdata \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*  # Limpa arquivos temporários para reduzir o tamanho da imagem

# Define o diretório de trabalho
WORKDIR /ansible

# Copia os scripts Ansible para o contêiner
COPY . .

# Define o comando padrão (pode ser bash ou rodar o playbook)
CMD ["bash"]
# ou para rodar automaticamente o playbook
# CMD ["ansible-playbook", "seu_playbook.yml"]
