# Usa a imagem base do Ubuntu
FROM ubuntu:20.04

# Definir as variáveis de ambiente para evitar a interação durante a instalação do tzdata
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=America/Sao_Paulo

# Edita o arquivo /etc/apt/sources.list para descomentar as linhas do repositório 'universe'
RUN sed -i 's/^# deb/deb/' /etc/apt/sources.list && \
    cat /etc/apt/sources.list | grep 'universe'

# Atualiza o sistema e instala Ansible, Git, Nano, Net-Tools e iproute2
RUN apt-get update && \
    apt-get install -y software-properties-common ansible git nano net-tools iproute2 tzdata && \
    apt-get clean

# Atualiza os pacotes novamente após editar o sources.list
RUN apt-get update

# Definir o diretório de trabalho
WORKDIR /app

# Definir variáveis de ambiente que serão passadas no build
ARG GIT_TOKEN
ARG GIT_USERNAME
ARG GIT_EMAIL

# Configurar Git com as credenciais fornecidas
RUN git config --global user.name "$GIT_USERNAME" && \
    git config --global user.email "$GIT_EMAIL" && \
    git config --global credential.helper store && \
    echo "https://${GIT_USERNAME}:${GIT_TOKEN}@github.com" > /root/.git-credentials

# Copia os scripts Ansible para o contêiner
COPY . .

# Define o comando padrão
CMD ["bash"]