#!/usr/bin/env bash
set -e
source ./buildconfig.sh

export OTP_VERSION="19.1.6"
echo $OTP_VERSION > /etc/container_environment/OTP_VERSION

header "install Erlang"
export OTP_DOWNLOAD_URL="https://github.com/erlang/otp/archive/OTP-${OTP_VERSION}.tar.gz"
export OTP_DOWNLOAD_SHA256="8fbe222233e14bffee40214641a44d0faef5457040e7ce5a85c3b9ce5f895777"
export runtimeDeps='libodbc1 libsctp1'
export buildDeps='unixodbc-dev libsctp-dev'
apt-get install -y --no-install-recommends $runtimeDeps && apt-get install -y --no-install-recommends $buildDeps

curl -fSL -o otp-src.tar.gz "$OTP_DOWNLOAD_URL" \
	&& echo "$OTP_DOWNLOAD_SHA256 otp-src.tar.gz" | sha256sum -c - \
	&& mkdir -p /usr/src/otp-src \
	&& tar -xzf otp-src.tar.gz -C /usr/src/otp-src --strip-components=1 \
	&& rm otp-src.tar.gz \
	&& cd /usr/src/otp-src \
	&& ./otp_build autoconf \
	&& ./configure --enable-sctp \
	&& make -j$(nproc) \
	&& make install \
	&& find /usr/local -name examples | xargs rm -rf \
	&& apt-get purge -y --auto-remove $buildDeps \
	&& rm -rf /usr/src/otp-src

header "install Erlang tools"
export REBAR_VERSION="2.6.4"

export REBAR_DOWNLOAD_URL="https://github.com/rebar/rebar/archive/${REBAR_VERSION}.tar.gz" \
export REBAR_DOWNLOAD_SHA256="577246bafa2eb2b2c3f1d0c157408650446884555bf87901508ce71d5cc0bd07" \
mkdir -p /usr/src/rebar-src \
	&& curl -fSL -o rebar-src.tar.gz "$REBAR_DOWNLOAD_URL" \
	&& echo "$REBAR_DOWNLOAD_SHA256 rebar-src.tar.gz" | sha256sum -c - \
	&& tar -xzf rebar-src.tar.gz -C /usr/src/rebar-src --strip-components=1 \
	&& rm rebar-src.tar.gz \
	&& cd /usr/src/rebar-src \
	&& ./bootstrap \
	&& install -v ./rebar /usr/local/bin/ \
	&& rm -rf /usr/src/rebar-src

export REBAR3_VERSION="3.3.2"

export REBAR3_DOWNLOAD_URL="https://github.com/erlang/rebar3/archive/${REBAR3_VERSION}.tar.gz" \
export REBAR3_DOWNLOAD_SHA256="ccbc27355727090b1fdde7497ab2485c3509e2fd14b48a93276b285b5760d092" \
mkdir -p /usr/src/rebar3-src \
	&& curl -fSL -o rebar3-src.tar.gz "$REBAR3_DOWNLOAD_URL" \
	&& echo "$REBAR3_DOWNLOAD_SHA256 rebar3-src.tar.gz" | sha256sum -c - \
	&& tar -xzf rebar3-src.tar.gz -C /usr/src/rebar3-src --strip-components=1 \
	&& rm rebar3-src.tar.gz \
	&& cd /usr/src/rebar3-src \
	&& HOME=$PWD ./bootstrap \
	&& install -v ./rebar3 /usr/local/bin/ \
	&& rm -rf /usr/src/rebar3-src
