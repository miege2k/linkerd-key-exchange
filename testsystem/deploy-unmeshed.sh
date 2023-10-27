#!/bin/sh
kubectl apply \
	-f svc/nameapi1.yaml \
	-f svc/helloworld.yaml \
	-f svc/goodbyeworld.yaml \
	-f svc/goodbyeworld2.yaml 
