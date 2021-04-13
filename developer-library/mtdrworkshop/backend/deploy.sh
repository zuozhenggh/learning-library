#!/bin/bash
## MyToDoReact version 1.0.
##
## Copyright (c) 2021 Oracle, Inc.
## Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/
export CURRENTTIME=$( date '+%F_%H:%M:%S' )
echo CURRENTTIME is $CURRENTTIME  ...this will be appended to generated deployment yaml
cp ./backend/src/main/k8s/app.yaml app-$CURRENTTIME.yaml
#may hit sed incompat issue with mac
sed -i "s|%DOCKER_REGISTRY%|${DOCKER_REGISTRY}|g" app-$CURRENTTIME.yaml
if [ -z "$1" ]; then
    kubectl apply -f app-$CURRENTTIME.yaml -n mtdrworkshop
else
    kubectl config use-context $1
    kubectl apply -f app-$CURRENTTIME.yaml -n mtdrworkshop
fi
#kubectl create -f app-$CURRENTTIME.yaml  -n mtdrworkshop
