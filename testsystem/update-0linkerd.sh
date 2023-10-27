#!/bin/bash
# linkerd installieren 
# eigene zertifikate setzen

echo "\n########## install crds\n \n"
#linkerd install | kubectl apply -f -
linkerd install --crds | kubectl apply -f -

echo "\n########## Install zertifikate\n \n "
linkerd install \
--set proxyInit.runAsRoot=true \
--identity-trust-anchors-file certificates/ca.crt \
--identity-issuer-certificate-file certificates/intermediate.crt \
--identity-issuer-key-file certificates/intermediate.key \
 | kubectl apply -f -

