#!/usr/bin/env bash
set -e
source ./buildconfig.sh

echo /root > /etc/container_environment/HOME

apt-key adv --fetch-keys http://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc \
  && apt-get update \
  && apt-get install -y esl-erlang

wget -q https://github.com/elixir-lang/elixir/releases/download/v1.3.4/Precompiled.zip \
  && unzip -dnq /usr/local Precompiled.zip \
  && rm Precompiled.zip

/usr/local/bin/mix local.hex --force \
  && /usr/local/bin/mix local.rebar --force
