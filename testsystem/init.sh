#!/bin/bash
# inizialisiert minikube 
# lenkt docker und kubectl auf minikube um 
# buildet die container in dem minikube wenn das umlenken funktioniert hat

minikube start --cpus='8' --memory='24000MiB' && sleep 10s && eval $(minikube -p minikube docker-env) && ./init_container.sh
