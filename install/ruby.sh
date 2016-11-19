#!/usr/bin/env bash
set -e
source ./buildconfig.sh

export RUBY_VERSION=2.3.1
export BUNDLER_VERSION=1.13.6

export buildDeps='bison libgdbm-dev autoconf build-essential zlib1g-dev libncurses5-dev automake libtool'
apt-get install -y --no-install-recommends $buildDeps
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
source /etc/profile.d/rvm.sh \
  && rvm install $RUBY_VERSION \
  && rvm use $RUBY_VERSION --default

header "install bundler"
gem install bundler --version "$BUNDLER_VERSION"

header "install railsr"
gem install rails -v 4.2.6
