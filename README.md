# ELK Stack Log Analytics

## 1. Project Summary

This project is an Internal Log Analytics and Search Platform based on the ELK Stack.

The platform collects, parses, stores, searches, and visualizes application logs using:

- Elasticsearch for storing, indexing, and searching logs
- Logstash for collecting and parsing log data
- Kibana for log visualization and analysis
- Docker Compose for running the ELK services
- Terraform for provisioning the Azure infrastructure
- Microsoft Azure Virtual Machine for hosting the platform

The log processing flow is:

Application Logs  
↓  
Logstash  
↓  
Elasticsearch  
↓  
Kibana  
↓  
Dashboards

The project uses an application log dataset containing 100 log records.

Logstash reads the dataset, extracts structured fields using Grok, processes timestamps, and sends the logs to Elasticsearch under the `project-logs` index.

Kibana is used to search and visualize the processed logs through dashboards showing log levels, errors, HTTP status codes, and log activity over time.

The secured Azure deployment also includes authentication, HTTPS access for Kibana, restricted network exposure, operating system patching, log retention, and troubleshooting documentation.

---

## 2. Requirements

### Required Software

- Docker Desktop
- Docker Compose
- A web browser
- Terraform, only if deploying the Azure infrastructure
- Azure CLI, only if managing the Azure deployment
- Git, optional

### Docker Images

The project uses:

- Elasticsearch 9.5.3
- Logstash 9.5.3
- Kibana 9.5.3

### Azure Deployment Requirements

For Azure deployment:

- Microsoft Azure subscription
- Ubuntu Linux virtual machine
- Terraform
- Azure CLI
- SSH client

### Python Dependencies

This project does not use Python and does not require external Python libraries.

A `requirements.txt` file is included because it is required by the submission structure.

---

## 3. Installation

### Step 1: Extract the Project

Extract the submitted ZIP file without renaming or restructuring the provided folders.

The required project structure is:

- `01_data/` — dataset files
- `02_src/` — Docker, ELK, Logstash, and Terraform files
- `03_assets/` — screenshots and project visuals
- `requirements.txt`
- `README.md`

### Step 2: Verify Docker

Make sure Docker Desktop is installed and running.

Verify that Docker and Docker Compose are available on the system.

### Step 3: Configure Environment Variables

The real deployment `.env` file is not included because it contains sensitive credentials.

A `.env.example` file should be included in `02_src/`.

Create a local `.env` file based on `.env.example` and enter valid credentials before starting the project.

Example:

ELASTIC_USER=elastic  
ELASTIC_PASSWORD=CHANGE_ME  
KIBANA_USER=kibana_system  
KIBANA_PASSWORD=CHANGE_ME

### Step 4: No Python Installation Required

No `pip install` command is required.

The `requirements.txt` file contains no Python package dependencies because the project runs using Docker Compose and the ELK Stack.

---

## 4. Run the Project

### Step 1: Open the Source Directory

Open a terminal and navigate to the `02_src` directory.

### Step 2: Start the ELK Stack

Run the Docker Compose configuration.

This starts:

- Elasticsearch
- Logstash
- Kibana

### Step 3: Check the Services

Verify that all three containers are running successfully.

The expected services are:

- `elasticsearch-secure`
- `logstash-secure`
- `kibana-secure`

### Step 4: Verify Elasticsearch

Elasticsearch requires valid authentication credentials.

The secured deployment restricts Elasticsearch access to localhost.

Requests without valid credentials are rejected.

The processed sample logs are stored in the:

`project-logs`

index.

The expected document count is:

100 records

### Step 5: Verify Logstash

Logstash processes the dataset using:

- File input
- Grok parsing
- Date processing
- Fingerprint processing

The expected result is:

0 Grok parsing failures

### Step 6: Open Kibana

Kibana is available through port:

`5601`

The Azure demonstration environment uses HTTPS/TLS and requires valid login credentials.

Because a self-signed certificate is used for the demonstration environment, the browser may display a certificate trust warning.

The Kibana dashboard includes:

- Total log count
- Total errors
- Error rate
- Log count by level
- Status code distribution
- Errors over time

### Step 7: Stop the Project

The Docker Compose environment can be stopped when it is no longer required.

---

## 5. API Keys & Environment Variables

The project does not require third-party API keys.

Sensitive Elasticsearch and Kibana credentials are managed using environment variables.

Required environment variables include:

ELASTIC_USER  
ELASTIC_PASSWORD  
KIBANA_USER  
KIBANA_PASSWORD

The real `.env` file must not be included in the submission package.

Instead, an `.env.example` file should be provided with placeholder values.

Sensitive information that should not be included in the submission includes:

- Real passwords
- SSH private keys
- Azure credentials
- API tokens
- Terraform state files
- Other private secrets

### Security Configuration

The secured Azure deployment includes the following controls:

- Elasticsearch authentication is enabled.
- Kibana requires user authentication.
- HTTPS/TLS is enabled on the Kibana web interface using a self-signed certificate.
- Elasticsearch is restricted to localhost.
- Logstash is restricted to localhost.
- SSH uses public-key authentication.
- Password-based SSH authentication is disabled.
- The Ubuntu host was updated with the latest available system and security updates.
- Docker services use an automatic restart policy.
- The `.env` file is protected with restricted permissions.
- Elasticsearch Index Lifecycle Management is configured for the `project-logs` index.
- The `project-logs-retention` policy uses a 30-day retention period.
- A troubleshooting guide is included for service and log checks.

---

## 6. Known Issues

- Elasticsearch is configured as a single-node deployment.
- The Kibana HTTPS certificate is self-signed, so browsers may display a certificate trust warning.
- Kibana remains externally accessible on port 5601 for demonstration purposes.
- SSH remains externally accessible for authorized team members using public-key authentication.
- The project uses a sample dataset containing 100 log records rather than a large production dataset.
- The current version does not include AI-based anomaly detection.
- The project is designed as an internal log analytics demonstration rather than a full SIEM solution.

### Future Improvements

Possible future improvements include:

- Use a trusted CA-signed certificate for Kibana.
- Apply stricter source IP restrictions for Kibana and SSH.
- Deploy a multi-node Elasticsearch cluster.
- Add automated alerting for high error rates.
- Support larger and more diverse production log sources.
- Add more Logstash parsing patterns.
- Add advanced operational metrics.
- Add AI-based anomaly detection and automated log analysis.
