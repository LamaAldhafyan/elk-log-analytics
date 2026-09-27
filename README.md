# ELK Stack Log Analytics

Internal Log Analytics and Search Platform based on the ELK Stack.

## Project Description

This project provides a centralized platform for collecting, parsing, storing, searching, and visualizing application logs.

The platform uses the ELK Stack:

* Elasticsearch for storing and searching logs
* Logstash for collecting and parsing logs
* Kibana for visualization and analysis
* Docker Compose for running the ELK Stack
* Terraform for Azure infrastructure provisioning
* Azure Virtual Machine for hosting the platform

## Architecture

The log processing flow is:

Application Log Dataset
→ Logstash
→ Elasticsearch
→ Kibana

Logstash reads the application log dataset, parses each record using Grok, converts the timestamp, and sends the structured logs to Elasticsearch.

Kibana connects to Elasticsearch and provides dashboards for analyzing the logs.

## Project Structure

```text
ELK_Stack_Group01_Code_v1/
├── 01_data/
│   └── app.log
├── 02_src/
│   ├── compose.yaml
│   ├── logstash/
│   │   └── logstash.conf
│   └── terraform/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       ├── versions.tf
│       └── .terraform.lock.hcl
├── 03_assets/
│   ├── elk-dashboard.png
│   ├── error-status-analysis.png
│   └── log-summary.png
├── requirements.txt
└── README.md
```

## Technologies

* Elasticsearch 9.5.3
* Logstash 9.5.3
* Kibana 9.5.3
* Docker
* Docker Compose
* Terraform
* Microsoft Azure
* Ubuntu Linux
* Bash

## Prerequisites

To run the ELK Stack locally, install:

* Docker Desktop with Docker Compose
* Git (optional)

Terraform is required only if the Azure infrastructure needs to be provisioned from the Terraform configuration.

No Python dependencies are required for this project.

## Running the ELK Stack

Open a terminal in the `02_src` directory:

```bash
cd 02_src
```

Start the ELK services:

```bash
docker compose up -d
```

Check the running containers:

```bash
docker compose ps
```

The services use the following ports:

* Elasticsearch: `9200`
* Kibana: `5601`
* Logstash: `5044`

## Logstash Pipeline

The Logstash pipeline consists of the following stages:

1. File input reads `01_data/app.log`
2. Grok parses the log records
3. Date filter converts the log timestamp to Elasticsearch `@timestamp`
4. Fingerprint generates a unique document ID
5. Elasticsearch stores the parsed records in the `project-logs` index

The extracted fields include:

* `timestamp`
* `level`
* `service`
* `status_code`
* `log_message`

## Dataset

The current test dataset contains 100 application log records.

The dataset includes:

* INFO
* WARNING
* ERROR

It also contains multiple services and HTTP status codes, including:

* 200
* 201
* 204
* 401
* 404
* 408
* 429
* 500
* 502
* 503
* 504

## Verification

Check the number of documents stored in Elasticsearch:

```bash
curl -s http://localhost:9200/project-logs/_count
```

Check for Grok parsing failures:

```bash
curl -s "http://localhost:9200/project-logs/_count?q=tags:grokparsefailure"
```

Expected test results:

* Total log records: 100
* Grok parsing failures: 0
* Error records: 22
* Error rate: 22%

## Kibana

Kibana is available on the Azure VM:

http://20.5.78.25:5601

The dashboard provides visualizations including:

* Total log count
* Total errors
* Error rate
* Log count by level
* Status code distribution
* Errors over time

### Dashboard

![Kibana Dashboard](03_assets/elk-dashboard.png)

### Error & Status Analysis

![Error & Status Analysis](03_assets/error-status-analysis.png)

### Log Summary

![Log Summary](03_assets/log-summary.png)

## Terraform

The `02_src/terraform` directory contains the Terraform configuration used to provision the Azure infrastructure.

Main Terraform files:

* `main.tf`
* `variables.tf`
* `outputs.tf`
* `versions.tf`
* `.terraform.lock.hcl`

Terraform state files and sensitive configuration files are intentionally excluded from the submission.

## Limitations

* Elasticsearch security is disabled in the current demonstration environment.
* Elasticsearch is configured as a single-node deployment.
* The project uses a sample application log dataset rather than a large production dataset.
* The current version does not implement AI-based anomaly detection.

## Future Improvements

Possible future improvements include:

* Enabling Elasticsearch security and authentication
* Deploying a larger distributed Elasticsearch cluster
* Using larger and more diverse production-like datasets
* Adding automated alerting
* Adding AI-based anomaly detection and log analysis
