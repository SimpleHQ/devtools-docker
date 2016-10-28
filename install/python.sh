#!/usr/bin/env bash
set -e
source ./buildconfig.sh

export PYTHON_PIP_VERSION=8.1.2

if [ ! -e /usr/local/bin/pip3 ]; then
	wget -O /tmp/get-pip.py 'https://bootstrap.pypa.io/get-pip.py'
	python3 /tmp/get-pip.py "pip==$PYTHON_PIP_VERSION"
	rm /tmp/get-pip.py
fi

cd /usr/bin \
	&& ln -s pydoc3 /usr/local/bin/pydoc \
	&& ln -s python3 /usr/local/bin/python

pip install awscli
