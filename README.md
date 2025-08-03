# node-todo-cicd

Run these commands:

sudo apt install nodejs

sudo apt install npm

sudo npm install

node app.js

# 🚀 DevSecOps CI/CD Pipeline for Node.js Todo App

This project demonstrates a complete **CI/CD pipeline** for a Node.js-based Todo application (`node-todo-cicd`) using **Jenkins**, **Docker**, and **Kubernetes** on AWS EC2. It includes DevSecOps practices like automated code scanning and vulnerability detection, as well as real-time **monitoring using Prometheus and Grafana**.

---

## 📌 Project Objectives

- ✅ Enable automatic Jenkins pipeline triggering using GitHub webhooks
- ✅ Build and tag Docker images dynamically based on commits
- ✅ Perform code quality checks with **SonarQube**
- ✅ Scan containers for vulnerabilities using **Trivy** and **OWASP Dependency-Check**
- ✅ Deploy app on a Kubernetes cluster (kubeadm-based)
- ✅ Monitor pod and node-level metrics using **Prometheus & Grafana**

---

## 🧱 Infrastructure Architecture

| Instance        | Purpose                             |
|----------------|-------------------------------------|
| EC2 Instance 1  | Jenkins, Docker, Trivy, SonarQube   |
| EC2 Instance 2  | Kubernetes Master, Prometheus, Grafana |
| EC2 Instance 3  | Kubernetes Worker Node              |

---

## 🛠️ Tools & Technologies Used

- **CI/CD:** Jenkins, GitHub
- **Containerization:** Docker
- **Orchestration:** Kubernetes (kubeadm)
- **Security:** Trivy, OWASP Dependency-Check, SonarQube
- **Monitoring:** Prometheus, Grafana, node-exporter, kube-state-metrics
- **Cloud:** AWS EC2

---

## 📦 Pipeline Stages

1. **Trigger:** GitHub webhook triggers Jenkins on push
2. **Build:** Jenkins builds and tags Docker image
3. **Scan:** SonarQube, Trivy, and OWASP analyze the code and image
4. **Push:** Image pushed to DockerHub (optional)
5. **Deploy:** Kubernetes manifests deploy app on the cluster
6. **Monitor:** Prometheus scrapes metrics; Grafana visualizes them

---

## 📊 Monitoring Setup

- **Prometheus Pod:** Custom deployment (no Helm)
- **Grafana Pod:** Exposed via NodePort
- **node-exporter & kube-state-metrics** for metrics collection
- Dashboards include CPU usage, pod health, memory, etc.

---

## 📁 Repository Structure

```bash
.
├── Jenkinsfile                    # CI/CD pipeline script
├── k8s/
│   ├── deployment.yaml            # Kubernetes deployment for todo app
│   ├── prometheus.yaml            # Prometheus manifest
│   └── grafana.yaml               # Grafana manifest
├── sonar-project.properties       # SonarQube config
├── Dockerfile                     # Docker build file for app
├── README.md                      # You're reading it!
## END THE 
