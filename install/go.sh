#!/usr/bin/env bash
set -e
source ./buildconfig.sh

export GOLANG_VERSION=1.7.3
export GOLANG_DOWNLOAD_URL=https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
export GOLANG_DOWNLOAD_SHA256=508028aac0654e993564b6e2014bf2d4a9751e3b286661b0b0040046cf18028e

curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
	&& echo "$GOLANG_DOWNLOAD_SHA256  golang.tar.gz" | sha256sum -c - \
	&& tar -C /usr/local -xzf golang.tar.gz \
	&& rm golang.tar.gz

export GOPATH=/go
echo $GOPATH > /etc/container_environment/GOPATH

export PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

header "install glide"
export GLIDE_VERSION=0.12.3
curl -Ls https://github.com/Masterminds/glide/releases/download/${GLIDE_VERSION}/glide-${GLIDE_VERSION}-linux-amd64.tar.gz | tar -xz --strip-components=1 -C /tmp \
  && mv /tmp/glide /usr/local/bin/ \
  && rm -rf /tmp/*

header "install gore"
go get github.com/motemen/gore \
  && go get github.com/nsf/gocode \
  && go get github.com/k0kubun/pp \
  && go get golang.org/x/tools/cmd/godoc
