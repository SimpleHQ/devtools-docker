#!/usr/bin/env bash
set -e
source ./buildconfig.sh

export ELIXIR_VERSION=1.6.2
export HOME=/root
echo $HOME > /etc/container_environment/HOME

echo "deb http://packages.erlang-solutions.com/ubuntu xenial contrib" >> /etc/apt/sources.list \
  && apt-key adv --fetch-keys http://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc \
  && apt-get update \
  && apt-get install -y esl-erlang

wget -q https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip \
  && unzip -nq -d /usr/local Precompiled.zip \
  && rm Precompiled.zip

/usr/local/bin/mix local.hex --force \
  && /usr/local/bin/mix local.rebar --force
