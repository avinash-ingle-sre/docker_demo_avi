# Production-Grade Containers & Kubernetes Deployments

Hands-on repository containing microservices architecture patterns, multi-stage Docker builds, Kubernetes manifests, and Istio service mesh configurations.

---

## 📂 Repository Index

| Component | Technology Stack | Description |
| :--- | :--- | :--- |
| **`gcp-boutique-microservices/`** | GKE, Istio, Skaffold, K8s | Complete 10-tier microservices application deployment with traffic routing and automated build triggers |
| **`microservice-k8s/`** | Python (Flask), Docker, K8s | Resilient order microservice with non-root security, resource limits, and health probes |
| **`compose-app/`** | Docker Compose | Multi-container local orchestration setup |
| **`gke-kubernetes-core/`** | Kubernetes Core Objects | Production pods, services, and ingress configurations |

---

## 🚀 Key Architectural Highlights
* **Service Mesh:** Istio VirtualServices, Gateways, and egress whitelisting for Google APIs.
* **Declarative Deployments:** Highly available multi-replica services with strict CPU/memory requests and limits.
* **Developer Workflow:** Continuous development loop configured via `skaffold.yaml` and GCP Cloud Build pipelines.

---

## 👤 Maintainer
* **Avinash Ingle** - *Site Reliability & Cloud Operations Engineer*
