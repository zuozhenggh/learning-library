#!/bin/bash
## MyToDoReact version 1.0.
##
## Copyright (c) 2021 Oracle, Inc.
## Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/
SCRIPT_DIR=$(dirname $0)
export CURRENTTIME=$( date '+%F_%H:%M:%S' )
echo CURRENTTIME is $CURRENTTIME  ...this will be appended to generated deployment yaml
cp todolistapp-helidon-se-deployment.yaml todolistapp-helidon-se-deployment-$CURRENTTIME.yaml
#may hit sed incompat issue with mac
sed -i "s|%DOCKER_REGISTRY%|${DOCKER_REGISTRY}|g" todolistapp-helidon-se-deployment-$CURRENTTIME.yaml
if [ -z "$1" ]; then
    kubectl apply -f $SCRIPT_DIR/todolistapp-helidon-se-deployment-$CURRENTTIME.yaml -n todoapplication
else
    kubectl apply -f <(istioctl kube-inject -f $SCRIPT_DIR/supplier-helidon-se-deployment-$CURRENTTIME.yaml ) -n todoapplication
fi
kubectl create -f $SCRIPT_DIR/todolistapp-helidon-se-service.yaml  -n todoapplication
