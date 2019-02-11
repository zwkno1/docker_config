#!/bin/bash
read -p "input username:" username
read -p "input password:" password
BASIC_AUTH=$(echo -n "${username}:${password}"|base64)
echo "basic_auth: $BASIC_AUTH"
sed -i -e "s/basic_auth:.*$/basic_auth: \"${BASIC_AUTH}\"/g" registry-web/config/config.yml
docker run --rm --entrypoint htpasswd registry -Bbn $username $password > registry/config/auth/nginx.htpasswd

