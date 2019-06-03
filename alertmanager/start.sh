#!/bin/bash
docker run -d --restart=always -v /opt/docker_config/alertmanager/config/alertmanager.yml:/etc/alertmanager/alertmanager.yml --name alertmanager --net=host docker.io/prom/alertmanager:latest
docker run -d --name=am-executor --net=host -v /opt:/opt prometheus-am-executor -l ":8088" /opt/docker_config/alertmanager/alarm.sh
