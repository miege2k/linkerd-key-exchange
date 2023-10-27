#!/bin/zsh
# neues ca (anker) erstellen
# neues intermediate_ca erstellen
# bundle erstellen
cd testsystem/certificates/

step certificate create root.linkerd.cluster.local ca_new.crt ca_new.key \
  --profile root-ca --no-password --insecure \
  --not-after=100h #--not-before=40h
  #--kty RSA --size 4096

step certificate create intermediate.linkerd.cluster.local intermediate_new.crt intermediate_new.key \
  --profile intermediate-ca --ca ca_new.crt --ca-key ca_new.key --no-password --insecure  \
  --not-after=100h #--not-before=40h
  #--kty RSA --size 4096

step certificate bundle ca_new.crt ca.crt bundle.crt


  