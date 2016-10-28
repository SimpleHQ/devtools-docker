#!/usr/bin/env bash
set -e

source ./buildconfig.sh

run ./prepare.sh

minimal_apt_get_install xz-utils siege wget groff git
run ./nodejs.sh
run ./python.sh

header "Finalizing..."
run apt-get remove -y autoconf automake
run apt-get autoremove
run apt-get clean
run rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
