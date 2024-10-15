# Usa a imagem base do Ubuntu
FROM ubuntu:20.04

# Definir as variáveis de ambiente para evitar a interação durante a instalação do tzdata
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=America/Sao_Paulo

# Atualiza o sistema e instala Ansible, Git, Nano, Net-Tools, SSH e iproute2
RUN apt-get update && \
    apt-get install -y software-properties-common ansible git nano net-tools iproute2 tzdata openssh-client && \
    apt-get clean

# Adicionar suporte ao SSH
# Cria a pasta .ssh e define as permissões corretas
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh

# Adicionar a chave privada SSH durante o build
# Aqui, o SSH_PRIVATE_KEY será passado como argumento no momento do build
ARG SSH_PRIVATE_KEY
RUN echo "$SSH_PRIVATE_KEY" > /root/.ssh/id_ed25519 && \
    chmod 600 /root/.ssh/id_ed25519

# Adicionar o GitHub ao arquivo known_hosts para evitar prompts de verificação
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

# Define o diretório de trabalho
WORKDIR /docker-ansible

# Copia os scripts Ansible para o contêiner
COPY . .

# Define o comando padrão
CMD ["bash"]