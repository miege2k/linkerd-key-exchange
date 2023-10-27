#!/bin/bash

service="helloworld"
#set url according to `minikube service list`
ip=`minikube service ${service} --url`
url="${ip}/${service}/"

for i in `seq 1 1000`;
do
    for j in `seq 1 4`;
    do
        curl -sL ${url}${j}
        echo
    done
done
