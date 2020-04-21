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
  jq \
  gnupg2

RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | tee  /etc/apt/sources.list.d/pgdg.list
RUN apt-get update -y
RUN apt-get install -y postgresql-client-12

RUN curl -s https://gitlab.com/postgres-ai/database-lab/-/raw/master/scripts/cli_install.sh | bash
