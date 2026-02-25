ubernetes Networking & Services Lab
This project demonstrates a practical hands-on exercise performed on a Kind (Kubernetes in Docker) cluster. The goal was to understand Pod communication, Label selectors, and different Service types in Kubernetes.

What I did in this Lab (Flow)
Cluster Setup: Created a multi-node Kubernetes cluster named devops-lab using Kind.

Pod Creation:

Deployed an Nginx web server pod (web-server) with labels app=web.

Later, deployed version-specific pods (web-v1, web-v2) to test granular traffic routing.

Service Connectivity:

ClusterIP: Created a service called web-app to allow internal communication within the cluster.

Label Selectors: Used kubectl patch to dynamically update service selectors, ensuring the service only routes traffic to pods with matching labels (app=web).

NodePort: Exposed the application externally using a NodePort service (web-nodeport), making the web server accessible via the Node's IP and a specific port (31038).

Verification:

Used temporary busybox pods to run wget commands.

Verified that the web-service correctly returns the Nginx welcome page.

Confirmed that Endpoints are automatically updated when new pods with matching labels are added.

Key Files
web-app-svc.yaml: Configuration for internal ClusterIP service.

web-nodeport-svc.yaml: Configuration for external NodePort access.

web-pods.yaml: Manifest of the running Nginx pods.

How to use
Apply the manifests:

Bash
kubectl apply -f .
Verify endpoints:

Bash
kubectl get endpoints web-app
