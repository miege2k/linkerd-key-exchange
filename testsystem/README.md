# Start Environment

Run `init.sh` to start an $$inikube test environment.
It does the following:
- Init a kubernetes with one node,
- connect extern kubectl with Kubernetes in the Minikube,
- Build all-self-made containers.

If the environment inside the Minikube is broken, you can run `minikube delete` and then run `init.sh` again.

## Showcases

1. Install Linkerd on a Kubernetes cluster and deploy with your own certificates.
2. Rotation of the certificates

## Usage
Run install and push services into Mesh:

Refresh all: `minikube delete && ./init.sh && ./update-0linkerd.sh && ./deploy-meshed.sh`

1. Run `update-0linkerd.sh` to install Linkerd with self-created certificates.
2. Run `deploy-unmeshed.sh` to deploy the unmeshed System.
3. Run `deploy-meshed.sh` to deploy meshed System.

Show tls activ: `linkerd viz -n default tap deploy`
Show IP from Pod: `kubectl describe pod helloworld-6bd689bf8d-6jpzd`

Rotate certificates:

1. Run `update-1bundle.sh` to update intermediate-CA with a bundle of both certificates.
2. Run `update-2rollingrestart`  to update the root-CA certificate in all sidecars.
3. Run `update-3identity.sh` to update intermediate-CA with the new intermediate-CA certificate.
4. Run `update-4ca.sh` to update Root-CA with the new certificate only.

Run `linkerd check` to see the new certificates.
Show one certificate: `linkerd identity -l app=nameapi`
show current Cert: `linkerd identity -n linkerd linkerd-destination`


Terminals:
ssh student@192.168.163.12
hshtestvm

Morgens
1. minikube delete && ./init.sh && ./update-0linkerd.sh && ./deploy-meshed.sh

Präsi
1. watch kubectl get pods
2. watch kubectl get pods -n linkerd-viz 
3. watch kubectl get pods -n linkerd 

Rotate certificates:

1. Run `update-1bundle.sh` to update intermediate-CA with a bundle of both certificates.
2. Run `update-2rollingrestart`  to update the root-CA certificate in all sidecars.
3. Run `update-3identity.sh` to update intermediate-CA with the new intermediate-CA certificate.
4. Run `update-4ca.sh` to update Root-CA with the new certificate only.

Beweis:
2. linkerd check >> snap_linkerd.txt
3. linkerd identity -l app=goodbyeworld >> snap_goodbye.txt

1. linkerd check >> snap_linkerd_new.txt
2. linkerd identity -l app=goodbyeworld >> snap_goodbye_new.txt
3. diff snap_linkerd.txt snap_linkerd_new.txt
4. diff snap_goodbye.txt snap_goodbye_new.txt




kubectl -n linkerd-viz rollout restart deploy

