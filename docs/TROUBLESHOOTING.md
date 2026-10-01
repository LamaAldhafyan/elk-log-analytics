# ELK Stack Troubleshooting Guide

## Check running services

docker compose ps

## Check Elasticsearch

curl -u "$ELASTIC_USER:$ELASTIC_PASSWORD" http://127.0.0.1:9201

## Check Kibana

curl -k --http1.1 -I https://localhost:5601

## Check Elasticsearch logs

docker logs elasticsearch-secure --tail 100

## Check Logstash logs

docker logs logstash-secure --tail 100

## Check Kibana logs

docker logs kibana-secure --tail 100

## Check open ports

sudo ss -tulpn

## Restart the ELK stack

docker compose restart

## Start the ELK stack

docker compose up -d

## Stop the ELK stack

docker compose down
