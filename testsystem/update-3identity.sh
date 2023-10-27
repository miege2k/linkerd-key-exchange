#!/bin/bash
# neues intermediate_ca einhängen
# event abhören ob das einhängen erfolgreich war

linkerd upgrade --set proxyInit.runAsRoot=true \
  --identity-issuer-certificate-file certificates/intermediate_new.crt \
  --identity-issuer-key-file certificates/intermediate_new.key \
  | kubectl apply -f - 

  kubectl get events --field-selector reason=IssuerUpdated -n linkerd