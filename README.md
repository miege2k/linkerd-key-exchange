# Project

Demonstration of an example application with Service Mesh (Linkerd).
This sample application is based on the [Repository](https://github.com/kiliandangendorf/hsh-favs-linkerd-prototype).
This demo includes the installation of all necessary components and the addition of the Service Mesh.
In addition, the certificates can be rotated.

To run these environment a system with more then 16 GB ram is needed.

This level provides all scripts for preparing the demo.
This script is executed only once.
Then the init.sh script is executed in the order test system.
The individual steps within the demo can be found in the folder [testsystem](./testsystem/README.md).

# Install Testenviroment

The script "install-testenviroment.sh" installs a minikube test environment on a Linux-based system.
The following tools are installed:
- docker
- docker compose
- minikube
- kubectl
- helm
- traefik
- step

# Create certifikates

"init-first-certs.sh" creates the first generation certificates.
"init-second-certs.sh" creates the second generation certificates and the bundle in which both certificates are stored.

# Update

"update_live.sh" synchronises all changed files on another system if the test system is running on another machine.