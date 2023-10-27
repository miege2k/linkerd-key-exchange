
## Overview
- [Overview](#overview)
  - [Use Linkerd](#use-linkerd)
  - [Install buggy demo app `emojivoto`](#install-buggy-demo-app-emojivoto)
- [Installation](#installation)
  - [Docker](#docker)
  - [Docker-Compose](#docker-compose)
  - [Post-installation Steps for Linux](#post-installation-steps-for-linux)
  - [Minikube](#minikube)
  - [`kubectl`](#kubectl)
  - [Firefox](#firefox)
  - [Linkerd](#linkerd)
  - [Bash-Completion](#bash-completion)


Running `docker ps` gives a strange result on first sight:
Just _one_ container named `minikube`.
_Within_ is where the fun begins.
Run `docker ps` to inspect the container-id of minikube.
Then jump into with:

```
docker exec -it <cotainer-id> /bin/bash
```

Here it is where `docker ps` gives the expected result:  
18 Kubernetes container and
27 Linkerd container (yes, 45 summed up).

You can easily get there by using:

```
minikube ssh
```

### Use Linkerd

Run the Dashboard:

```
linkerd dashboard
```

Since we use it headless, this command will throw one warning (never mind).
The Dashboards are there.

- Linkerd: http://localhost:50750
- Grafana: http://localhost:50750/grafana  
  Grafana visualizes metrics collected by Prometheus.

This is where we use the [`ssh`-tunnel](#port-forwarding) again.

```
ssh -nNT -L 12345:127.0.0.1:50750 favs
```

And checkout locally:  
http://localhost:12345

### Install buggy demo app `emojivoto`

```
curl -sL https://run.linkerd.io/emojivoto.yml | kubectl apply -f -
```

And it's already running! Check with:

```
kubectl -n emojivoto port-forward svc/web-svc 8080:80
```

(and for sure again the `ssh`-tunnel)

Now add Linkerd to this:

```
kubectl get -n emojivoto deploy -o yaml \
  | linkerd inject - \
  | kubectl apply -f -
```

First get manifest, then Linkerd adds annotations (the sidecars).
Kubernetes will perform a rolling deploy.

To see whats currently happening in namespace `emojivoto`:

```
linkerd -n emojivoto top deploy
```

To remove the `emojivoto` pods, give Kubernetes the manifest again but now with `delete` instead of `apply`:

```
curl -sL https://run.linkerd.io/emojivoto.yml | kubectl delete -f -
```

## Installation

What I have done so far from scratch on an Ubuntu 20.04...

### Docker

Install Docker as it stated here: https://docs.docker.com/engine/install/ubuntu/

```
sudo apt-get update
sudo apt-get install -yq apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -yq docker-ce docker-ce-cli containerd.io
```

(Note the `-yq` options for `install` (assume yes and be quiet). It's pain trying to copy several lines of commands and `apt-get` aborts 'cause you didn't wrote "Y".)

### Docker-Compose

Now docker-compose: https://docs.docker.com/compose/install/

```
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```

(We do not need docker-compose for our Service Mesh, but for testing it's helpful.)

### Post-installation Steps for Linux

Add `docker` to Sudoers:

```
sudo groupadd docker#if not already exists
sudo usermod -aG docker $USER
newgrp docker
```

(https://docs.docker.com/engine/install/linux-postinstall/)

### Minikube

Minikube should be enough for us.
It runs lightweight and should be easy to learn Kubernetes.
Also Linkerd recommends it ;)

```
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64
```

(https://minikube.sigs.k8s.io/docs/start/)

### `kubectl`

There is a `kubectl` within Minikube, but you'll always have to type several superfluous dashes what is _really_ annoying.
So lets just install it separate:

```
sudo snap install kubectl --classic
```

Check correct version (Linkerd needs 1.13 or above) with:

```
kubectl version --short
```

### Firefox

Needed for the X11 forwarding

```
sudo apt install firefox
```

### Linkerd

now you have to start minikube

```
minikube start
```

if you want to make changes

```
minikube delete
```

powerful cluster

```
minikube start --cpus='2' --memory='max'
```

This part is accordingly to the official Tutorial: https://linkerd.io/2/getting-started/

Download and run install script for Linkerd-CLI

```
curl -sL https://run.linkerd.io/install | sh
```

and add to the `$PATH` environment:

```
export PATH=$PATH:$HOME/.linkerd2/bin
```

To make sure, this happens for every shell you run, put this into the `.bashrc`:

```
echo "export PATH=$PATH:$HOME/.linkerd2/bin" >> ~/.bashrc
```

Check if everything went well:

```
linkerd version
```

(Now this should return `Server version: unavailable` what's natch since Linkerd is not installed on the Kubernetes cluster yet.)

Validate cluster:

```
linkerd check --pre
```

Install Linkerd on cluster:



```
linkerd install --crds | kubectl apply -f -
linkerd install --set proxyInit.runAsRoot=true | kubectl apply -f -
```

```
linkerd viz install | kubectl apply -f -
```

Validate installation:

```
linkerd check
```

### Bash-Completion

It is very useful to install bash-completion for the above installed programs.
Especially in `kubectl` you can compltete pod-names by pressing tab instead of typing huge pod-identifiers.

If bash-completion is not already installed:

```
apt-get install bash-completion
echo "source /etc/bash-completion" >> .bashrc
```

To make completion available in every shell, we put each `source` command into the `.bashrc`.

**Linkerd**

```
echo "source <(linkerd completion bash)" >> .bashrc
```

(For older bash or other OS check how to to with: `linkerd completion --help`)

**Minikube**

```
echo "source <(minikube completion bash)" >> .bashrc
```

(For older bash or other OS check how to to with: `minikube completion --help`)

**kubectl**

```
echo "source <(kubectl completion bash)" >> .bashrc
```

(For older bash or other OS check how to to with: `kubectl completion --help`)
