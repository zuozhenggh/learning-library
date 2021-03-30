#!/bin/bash
## MyToDoReact version 1.0.
##
## Copyright (c) 2021 Oracle, Inc.
## Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

echo deleting all secrets in mtdrworkshop namespace...
kubectl delete --all secrets -n mtdrworkshop

echo deleting generated-yaml dir...
rm -rf generated-yaml

echo deleting wallet dirs...
rm -rf wallet
