# Google Cloud Managed Service for Prometheus (GMP) & Host Observability

Implementation of hybrid infrastructure and application telemetry on Google Kubernetes Engine (GKE).

## Components
1. **PodMonitoring CRD:** Declarative scraping using `monitoring.googleapis.com/v1`.
2. **Node Exporter:** Host kernel metrics collection on port `:9100`.
3. **Managed Ingestion:** GCM Exporter pipeline with zero TSDB storage maintenance.

## PromQL Queries
* \`up{job="prom-example"}\`
* \`node_cpu_seconds_total\`
* \`100 - (avg by (instance) (rate(node_cpu_seconds_total{mode="idle"}[1m])) * 100)\`
