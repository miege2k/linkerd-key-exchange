#!/bin/bash

echo "delete deployments and services"
kubectl delete \
	-f svc/nameapi1.yaml \
	-f svc/nameapi2.yaml \
	-f svc/helloworld.yaml \
	-f svc/goodbyeworld.yaml \
	-f svc/goodbyeworld2.yaml

# -f svc/nameapi.yaml \


echo "delete trafficsplit"
kubectl delete \
	trafficsplits.split.smi-spec.io \
	nameapi-split
	goodbyeworld-split
