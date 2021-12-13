#!/usr/bin/env bash

CONTAINER_RUNTIME=$(command -v podman &> /dev/null && echo podman || echo docker)

mkdir -p monitoring/prometheus monitoring/grafana/data monitoring/grafana/provisioning

${CONTAINER_RUNTIME} run \
-d \
--rm \
--name prometheus \
-p 9090:9090 \
-v ./monitoring/prometheus:/etc/prometheus \
docker.io/prom/prometheus:v2.31.1 \
  --config.file=/etc/prometheus/prometheus.yml \
  --web.external-url=http://localhost:9090

${CONTAINER_RUNTIME} run \
-d \
--rm \
--name grafana \
-p 3000:3000 \
-v ./monitoring/grafana/data:/var/lib/grafana \
-v ./monitoring/grafana/provisioning:/etc/grafana/provisioning \
-e GF_SECURITY_ADMIN_USER=admin \
-e GF_SECURITY_ADMIN_PASSWORD=admin \
docker.io/grafana/grafana-oss:8.2.0
