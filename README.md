# ELK Log Analytics

Internal Log Analytics and Search Platform based on the ELK Stack.

## Architecture

The project uses:

* Elasticsearch for storing and searching logs
* Logstash for collecting and parsing logs
* Kibana for visualization and analysis
* Docker Compose for running the ELK stack
* Azure VM as the hosting environment

## Project Structure

```text
elk-log-analytics/
├── compose.yaml
├── README.md
├── logs/
│   └── app.log
├── logstash/
│   └── logstash.conf
└── .gitignore
```

## Logstash Pipeline

The pipeline reads application logs from:

```text
logs/app.log
```

Logstash parses each log using Grok and extracts the following fields:

* `timestamp`
* `level`
* `service`
* `status_code`
* `log_message`

The parsed timestamp is also mapped to Elasticsearch's `@timestamp` field.

Logs are stored in the Elasticsearch index:

```text
project-logs
```

## Running the ELK Stack

Start the services:

```bash
docker compose up -d
```

Check running containers:

```bash
docker ps
```

The services use the following ports:

* Elasticsearch: `9200`
* Kibana: `5601`
* Logstash: `5044`

## Verify Log Ingestion

Check the number of documents in the Elasticsearch index:

```bash
curl -s http://localhost:9200/project-logs/_count
```

The current test dataset contains **100 log records**.

Check for Grok parsing failures:

```bash
curl -s "http://localhost:9200/project-logs/_count?q=tags:grokparsefailure"
```

The current result is **0 parsing failures**.

## Current Test Dataset

The sample application log contains:

* INFO
* WARNING
* ERROR

It includes multiple services and HTTP status codes such as:

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

## Logstash Configuration

The Logstash pipeline uses:

* File input for reading `app.log`
* Grok filter for parsing log fields
* Date filter for setting `@timestamp`
* Fingerprint filter to generate unique document IDs
* Elasticsearch output for storing parsed logs
* Ruby debug output for troubleshooting


## Dashboard

![Kipana Dashboard](screenshots/elk-dashboard.png)


## Error & status analysis
![error&status-analysis](screenshots/error&status-analysis.png)

## Log Summary

![log summary](screenshots/log-summary.png)
