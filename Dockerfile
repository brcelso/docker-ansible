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

# Define o diretório de trabalho
WORKDIR /name: Build and Push Docker Image

on:
  workflow_dispatch:
  #push:
    #branches:
      #- main  # Mude para a branch desejada
  # Você também pode adicionar outros gatilhos, como pull requests

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Check out repository
      uses: actions/checkout@v3  # Versão mais atual do checkout

    - name: Log in to Docker Hub
      uses: docker/login-action@v2  # Versão mais atual do docker login
      with:
        username: ${{ secrets.DOCKER_USERNAME }}
        password: ${{ secrets.DOCKER_PASSWORD }}

    - name: Build Docker image
      run: |
        docker build -t celsosjunior/docker-ansible:latest .

    - name: Push Docker image
      run: |
        docker push celsosjunior/docker-ansible:latest

# Copia os scripts Ansible para o contêiner
COPY . .

# Define o comando padrão
CMD ["bash"]
