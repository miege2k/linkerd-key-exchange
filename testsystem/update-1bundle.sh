#!/bin/bash
# neues Bundle einhängen
# abhören ob das einhängen erfolgreich war

linkerd upgrade --set proxyInit.runAsRoot=true \
  --identity-trust-anchors-file certificates/bundle.crt | kubectl apply -f -

linkerd check --proxy

