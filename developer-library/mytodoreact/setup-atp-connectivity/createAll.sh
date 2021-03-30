#!/bin/bash
## MyToDoReact version 1.0.
##
## Copyright (c) 2021 Oracle, Inc.
## Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

if [[ $1 == "" ]]
then
  echo MTDRWORKSHOP_DB_WALLET_OBJECTSTORAGE_LINK not provided
  echo Required arguments is MTDRWORKSHOP_DB_WALLET_OBJECTSTORAGE_LINK.
  echo Usage example :  ./createAll.sh https://objectstorage.us-phoenix-1.oraclecloud.com/p/asdf/n/asdf/b/mtdrworkshop/o/Wallet_ORDERDB.zip
  exit
fi

source ../mtdrworkshop.properties
export SCRIPT_DIR=$(dirname $0)
export CURRENTTIME=$( date '+%F_%H:%M:%S' )
echo CURRENTTIME is $CURRENTTIME  ...this will be appended to generated yamls
mkdir generated-yaml

echo "MTDR DB ......"
echo "get wallet for mtdr db..."
mkdir wallet
cd wallet
curl -sL $1 --output wallet.zip ; unzip wallet.zip ; rm wallet.zip
echo "export values for contents of wallet zip..."
export mtdrdb_cwallet_sso=$(cat cwallet.sso | base64 | tr -d '\n\r' | base64 | tr -d '\n\r')
export mtdrdb_ewallet_p12=$(cat ewallet.p12 | base64 | tr -d '\n\r' | base64 | tr -d '\n\r')
export mtdrdb_keystore_jks=$(cat keystore.jks | base64 | tr -d '\n\r' | base64 | tr -d '\n\r')
export mtdrdb_ojdbc_properties=$(cat ojdbc.properties | base64 | tr -d '\n\r' | base64 | tr -d '\n\r')
export mtdrdb_README=$(cat README | base64 | tr -d '\n\r' | base64 | tr -d '\n\r')
export mtdrdb_sqlnet_ora=$(cat sqlnet.ora | base64 | tr -d '\n\r' | base64 | tr -d '\n\r')
export mtdrdb_tnsnames_ora=$(cat tnsnames.ora | base64 | tr -d '\n\r' | base64 | tr -d '\n\r')
export mtdrdb_truststore_jks=$(cat truststore.jks | base64 | tr -d '\n\r' | base64 | tr -d '\n\r')
cd ../
echo "replace values in mtdrdb yaml files (files are suffixed with ${CURRENTTIME})..."
eval "cat <<EOF
$(<$SCRIPT_DIR/atp-binding-mtdrdb.yaml)
EOF" > $SCRIPT_DIR/generated-yaml/atp-binding-mtdrdb-${CURRENTTIME}.yaml
echo "creating mtdrdb binding..."
kubectl create -f generated-yaml/atp-binding-mtdrdb-${CURRENTTIME}.yaml -n mtdrworkshop
