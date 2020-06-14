#!/bin/sh

CA="demoCA"
DIR="server"

NAME="server"
mkdir $DIR

#export OPENSSL_CONF=openssl.cnf

#秘密鍵生成・署名要求
openssl req -newkey rsa:2048 -keyout $DIR/server.pem -out $DIR/server_req.pem -subj "/C=JP/ST=Tokyo/O=EXAMPLE Corporation/OU=Sample Labs./CN=$(hostname)"

#apache用パスワード無し秘密鍵
openssl rsa -in $DIR/server.pem -out $DIR/server_nopass.pem

#認証曲がサーバの署名要求へ署名
openssl ca -in $DIR/server_req.pem -days 3650 -out $DIR/server_cert.pem -notext

