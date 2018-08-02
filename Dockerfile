FROM haproxy:1.8

ENV LUA_PATH /usr/local/etc/lua/?.lua;;

RUN set -ex ; \ 
	apt-get -y update; \
	apt-get install -y vim procps lua5.3 lua-socket liblua5.3-0 lua-luaossl curl

COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
COPY config.lua /usr/local/etc/lua/config.lua
COPY acme.lua /usr/local/etc/lua/acme.lua
COPY http.lua /usr/local/etc/lua/http.lua
COPY json.lua /usr/local/etc/lua/json.lua
COPY letsencrypt-x3-ca-chain.pem  /usr/local/etc/letsencrypt-x3-ca-chain.pem

