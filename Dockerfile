FROM debian:stretch-slim

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y \
  build-essential \
  apt-utils \
  ca-certificates \
  apt-transport-https \
  gnupg \
  curl \
  sudo


RUN curl https://gitlab.com/postgres-ai/database-lab/-/raw/master/scripts/cli_install.sh | bash

RUN echo "**** Installation NodeJS ****"
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs