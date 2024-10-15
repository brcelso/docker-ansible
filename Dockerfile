# Usa a imagem base do Ubuntu
FROM ubuntu:20.04

# Edita o arquivo /etc/apt/sources.list para garantir que o repositório principal esteja descomentado
RUN sed -i 's/^# deb http:\/\/archive.ubuntu.com\/ubuntu focal main universe/deb http:\/\/archive.ubuntu.com\/ubuntu focal main universe/' /etc/apt/sources.list && \
    cat /etc/apt/sources.list | grep 'focal main universe'

# Atualiza o sistema e instala Ansible, Git, Nano e Net-Tools
RUN apt-get update && \
    apt-get install -y software-properties-common ansible git nano net-tools && \
    apt-get clean

# Atualiza os pacotes novamente após editar o sources.list
RUN apt-get update

# Define o diretório de trabalho
WORKDIR /ansible

# Copia os scripts Ansible para o contêiner
COPY . .

# Define o comando padrão
CMD ["bash"]
