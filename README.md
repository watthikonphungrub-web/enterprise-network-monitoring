# Enterprise Network Monitoring & Analytics Infrastructure

## 📌 Project Overview
This project demonstrates an automated, End-to-End monitoring infrastructure tailored for enterprise environments. It focuses on tracking system health, monitoring network performance, and analyzing internet usage statistics in real-time.
![Monitoring Dashboard](images_screenshot.png)

## 🛠️ Architecture & Technologies
* **Infrastructure as Code (IaC):** Utilized **Terraform** to provision and manage Docker containers automatically.
* **Metrics Collection:** Deployed **Prometheus** alongside `node_exporter` for server-level metrics.
* **Enterprise Hardware Integration:** Configured `snmp_exporter` to extract detailed traffic and performance data from enterprise networking hardware, including routers, switches, and access points.
* **Alerting System:** Integrated **Alertmanager** with custom YAML rules for proactive incident response.
* **Data Reporting:** Designed the system to allow metrics extraction for professional documentation, automated data reporting, and deep-dive analysis using **Microsoft Excel**.

## 🚀 Key Features
* Automated deployment using a single `terraform apply` command.
* SNMP v2c/v3 integration for closed-system network appliances.
* Scalable configuration ready for enterprise deployment.

# Enterprise Network & Server Monitoring Project

This project demonstrates an automated, End-to-End monitoring infrastructure tailored for enterprise environments. It provides real-time visibility into server health using industry-standard Observability tools.

## Architecture & Technologies
* **Infrastructure as Code (IaC):** Utilized **Terraform** to provision and manage Docker containers automatically.
* **Metrics Collection:** Deployed **Prometheus** alongside `node_exporter` for server-level metrics.
* **Visualization:** Designed custom **Grafana** dashboards to provide insights into system performance.

## Key Features
* **Automated Deployment:** Deploy the entire stack using a single `docker-compose up -d` command.
* **Comprehensive Monitoring:** Tracks essential system resources in real-time.

## Dashboard Overview
This dashboard tracks the following key metrics:
* **CPU Utilization:** Real-time monitoring of CPU load.
* **Memory Usage:** Tracking RAM consumption.
* **Disk Space:** Monitoring available storage capacity.

## How to Run
* Clone this repository: `git clone <your-repo-link>`
* Deploy the stack: `docker-compose up -d`
* Access Grafana at: `http://localhost:3000`
