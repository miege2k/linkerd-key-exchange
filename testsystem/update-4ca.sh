#!/bin/bash
# alte ca aushängen

linkerd upgrade --set proxyInit.runAsRoot=true \
  --identity-trust-anchors-file=certificates/ca_new.crt | kubectl apply -f -
linkerd check --proxy

