#!/bin/bash
docker run -d --restart=always -v /opt/docker_config/prometheus/config:/etc/prometheus -v /opt/docker_config/prometheus/data:/prometheus --name prometheus --net=host prom/prometheus
