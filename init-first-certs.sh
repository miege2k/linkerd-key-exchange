#!/bin/zsh
# alte certifikate löschen
# ca (anker) erstellen
# intermediate_ca erstellen

cd testsystem/certificates/ && rm -f ./*

step certificate create root.linkerd.cluster.local ca.crt ca.key \
  --profile root-ca --no-password --insecure \
  --not-after=60h 
# --kty RSA --size 2048

step certificate create intermediate.linkerd.cluster.local intermediate.crt intermediate.key \
  --profile intermediate-ca --ca ca.crt --ca-key ca.key --no-password --insecure \
  --not-after=55h
# --kty RSA --size 2048 


# step certificate create leaf1.linkerd.cluster.local leaf1.crt leaf1.key \
#   --profile leaf --ca intermediate.crt --ca-key intermediate.key --no-password --insecure \
#   --not-after=120h

# verify intermediate.crt
step certificate verify ./intermediate.crt \
--roots "./ca.crt"

# # verify leaf1.crt
# step certificate verify ./leaf1.crt \
# --roots "./intermediate.crt"
