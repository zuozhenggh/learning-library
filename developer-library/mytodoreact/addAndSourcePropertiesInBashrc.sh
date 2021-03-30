#!/bin/bash
## MyToDoReact version 1.0.
##
## Copyright (c) 2021 Oracle, Inc.
## Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

echo "export MTDRWORKSHOP_LOCATION=~/mtdrworkshop/" >> ~/.bashrc
read -s -p "Client Wallet Password: " mtdrdb_walletPassword
echo "export mtdrdb_walletPassword=$mtdrdb_walletPassword" >>~/.bashrc

read -s -p "Database Admin Password: " mtdrdb_admin_password
echo "export mtdrdb_admin_password=$mtdrdb_admin_password" >>~/.bashrc

read -s -p "Database User Password: " mtdrdb_user_password
echo "export mtdrdb_user_password=$mtdrdb_user_password" >> ~/.bashrc

echo "source ~/mtdrworkshop/mtdrworkshop.properties" >> ~/.bashrc
source ~/.bashrc
