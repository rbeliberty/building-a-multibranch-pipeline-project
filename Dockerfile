FROM debian:stretch-slim
RUN groupadd -r -g 112 jenkins
RUN useradd -m -r -u 106 -g jenkins jenkins

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y \
  build-essential \
  apt-utils \
  ca-certificates \
  apt-transport-https \
  gnupg \
  curl \
  jq

RUN curl -s https://gitlab.com/postgres-ai/database-lab/-/raw/master/scripts/cli_install.sh | bash
