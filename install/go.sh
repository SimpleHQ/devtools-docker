#!/usr/bin/env bash
set -e
source ./buildconfig.sh

export GOLANG_VERSION=1.10
export GOLANG_DOWNLOAD_URL=https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
export GOLANG_DOWNLOAD_SHA256=b5a64335f1490277b585832d1f6c7f8c6c11206cba5cd3f771dcb87b98ad1a33

curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
	&& echo "$GOLANG_DOWNLOAD_SHA256  golang.tar.gz" | sha256sum -c - \
	&& tar -C /usr/local -xzf golang.tar.gz \
	&& rm golang.tar.gz

export GOPATH=/go
echo $GOPATH > /etc/container_environment/GOPATH

export PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

header "install dep"
export DEP_VERSION=0.3.2
curl -fsSL -o /usr/local/bin/dep https://github.com/golang/dep/releases/download/v${DEP_VERSION}/dep-linux-amd64 \
	&& chmod +x /usr/local/bin/dep

header "install other tools"
go get github.com/motemen/gore \
  && go get github.com/nsf/gocode \
  && go get github.com/k0kubun/pp \
  && go get golang.org/x/tools/cmd/godoc \
	&& go get honnef.co/go/tools/cmd/gosimple
