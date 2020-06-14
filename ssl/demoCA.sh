#!/bin/sh

CA="demoCA"

mkdir $CA
mkdir $CA/certs      # 認証局の証明書を入れる
mkdir $CA/private    # 認証局の秘密鍵を入れる
mkdir $CA/crl        # certificate revocation list 証明書失効リスト
mkdir $CA/newcerts   # 発行した証明書の pem ファイルを入れる

## --- 台帳（簡易DB）、証明書管理用ファイルを作成

echo 01 > $CA/serial     # 証明書のシリアルナンバー
echo 01 > $CA/crlnumber  # 失効操作時に番号を記録するらしい？
touch $CA/index.txt      # 証明書の台帳
touch $CA/index.txt.attr # 証明書の重複を許すか。古い資料には無いが必須

## --- 認証局の作成

#export OPENSSL_CONF=openssl.cnf # 変更に合わせた設定の読み込み

openssl req -x509 -days 3650 -newkey rsa:2048 -keyout $CA/private/cakey.pem -out $CA/cacert.pem -subj "/C=JP/ST=Tokyo/O=EXAMPLE Corporation/OU=Sample Labs./CN=$(hostname)"

