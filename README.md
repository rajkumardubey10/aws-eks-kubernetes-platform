# 🚀 Production-Grade Jenkins CI/CD Platform on AWS EKS

A **real-world, production-ready DevOps platform** demonstrating end-to-end infrastructure provisioning, CI/CD automation, Kubernetes security, and observability using **AWS, Terraform, Jenkins, Kubernetes, Prometheus, and Grafana**.

This project is designed and documented in a **freelancing delivery style**, reflecting how enterprise and startup clients expect DevOps platforms to be built, secured, and operated.

---

## 📌 Project Objectives

The primary objectives of this project are:

- Provision **production-ready Kubernetes infrastructure** using Infrastructure as Code
- Implement **secure and scalable CI/CD pipelines**
- Enforce **Kubernetes security, governance, and least privilege**
- Apply **zero-trust networking principles**
- Ensure **full observability and resource governance**
- Provide **clear documentation and execution proof** for handover and audits

---

## 🏗️ Architecture Overview

This platform follows a **cloud-native, security-first architecture**:

- Infrastructure is provisioned using **Terraform**
- Kubernetes runs on **Amazon EKS**
- CI/CD pipelines are implemented using **Jenkins**
- Governance enforced using **Kyverno & RBAC**
- Network isolation via **Kubernetes NetworkPolicies**
- Monitoring via **Prometheus & Grafana**
- Persistent storage via **EBS CSI Driver**
- Ingress handled by **AWS ALB**

> The architecture is designed to scale, remain secure, and be operable in real production environments.

---

## 🔄 Project Flow (End-to-End)

1. Terraform provisions AWS infrastructure (VPC, EKS, IAM)
2. Terraform state is stored securely in an S3 remote backend
3. Jenkins CI pipeline builds and pushes container images
4. Jenkins CD pipeline deploys workloads to EKS
5. RBAC restricts cluster access using least privilege
6. Kyverno enforces security and reliability policies
7. NetworkPolicies restrict pod-to-pod communication
8. Prometheus collects cluster and workload metrics
9. Grafana visualizes resource usage and cluster health

---

## 🛠️ Technology Stack

| Category | Tools |
|------|------|
| Cloud | AWS (EKS, VPC, IAM, EC2, ALB, EBS) |
| IaC | Terraform |
| CI/CD | Jenkins |
| Containers | Docker |
| Orchestration | Kubernetes |
| Security | RBAC, Kyverno, NetworkPolicies |
| Monitoring | Prometheus, Grafana |

---

## 📁 Repository Structure

```text
.
├── docker/                     # Dockerfiles (multi-stage, non-root)
├── eks/                        # Terraform EKS infrastructure
├── kubernetes/
│   ├── k8s-manifests/          # Deployments, Services, StatefulSets
│   └── rbac/                   # ServiceAccount, Role, RoleBinding
├── kyverno-policies/           # Kubernetes policy enforcement
├── network-policies/           # Zero-trust networking rules
├── jenkins/                    # CI/CD pipeline definitions
├── monitoring/                 # Prometheus & Grafana configs
├── screenshots/                # Execution proof
└── README.md
```

# 📸 Infrastructure, CI/CD & Observability – Execution Proof

This section provides **visual and contextual proof** of real infrastructure provisioning, Kubernetes operations, CI/CD automation, and observability.  
All screenshots are taken from a **real AWS EKS environment**, provisioned and operated using **Infrastructure as Code and production best practices**.

---

## 1️⃣ Terraform Remote Backend (State Management)

![Terraform Remote Backend - S3 State](screenshots/aws-terraform/terraform-backend.png)

### 🖼️ Terraform Remote Backend – Centralized State & Locking (S3)
**Description:**  
This screenshot shows **Terraform configured with a remote backend using Amazon S3**, where the `terraform.tfstate` file and the associated state lock file are securely stored.

Instead of keeping state locally, the infrastructure state is **centralized and managed remotely**, enabling safe collaboration and reliable infrastructure changes across environments.

**What this confirms:**
- Terraform state is stored in **Amazon S3**, not on a local machine
- **State locking** is enabled to prevent concurrent or conflicting Terraform runs
- Infrastructure changes are **tracked, versioned, and auditable**
- Multiple engineers can safely work on the same infrastructure

**Why this matters in production & client environments:**
- Prevents **state corruption** during parallel deployments
- Enables **team-based infrastructure management**
- Supports **CI/CD-driven Terraform executions**
- Aligns with **enterprise Infrastructure as Code best practices**

---

## 2️⃣ Terraform Apply – EKS Infrastructure Provisioning

![Terraform Apply - EKS Infrastructure Provisioning](screenshots/aws-terraform/terraform-apply.png)

### 🖼️ Terraform Apply – Automated EKS Infrastructure Provisioning
**Description:**  
This screenshot captures a **successful `terraform apply` execution**, where the complete Amazon EKS infrastructure is provisioned using **Infrastructure as Code (IaC)**.

**What this confirms:**
- Amazon **EKS cluster** creation
- **VPC, subnets, and networking components** provisioned automatically
- **IAM roles, access policies, and OIDC provider** configured
- Remote backend usage with **state locking enabled**
- Infrastructure created with **zero manual console configuration**

**Why this matters in production:**
- Ensures **repeatable and predictable deployments**
- Eliminates configuration drift
- Enables safe rollbacks and controlled changes
- Supports long-term platform scalability

---

## 3️⃣ AWS VPC – Network Foundation for EKS

![AWS VPC for EKS Cluster](screenshots/aws-terraform/vpc-eks.png)

### 🖼️ AWS VPC – Network Foundation for EKS Cluster
**Description:**  
This screenshot shows the **custom Amazon VPC** created specifically to host the Amazon EKS cluster.  
The VPC was **fully provisioned using Terraform**, ensuring a reproducible and secure network setup.

**What this confirms:**
- Dedicated VPC with controlled **CIDR range**
- Subnets distributed across **multiple Availability Zones**
- Centralized routing configuration
- Network isolation from other environments

**Why this matters in production:**
- Provides **secure network isolation**
- Enables **high availability and fault tolerance**
- Supports load balancers, node groups, and pod networking
- Aligns with AWS Well-Architected networking principles

---

## 4️⃣ Amazon EKS – Kubernetes Control Plane Status

![Amazon EKS Cluster Status](screenshots/aws-terraform/eks-cluster-status.png)

### 🖼️ Amazon EKS Cluster – Production-Ready Control Plane (ACTIVE)
**Description:**  
This screenshot shows the **Amazon EKS cluster in an ACTIVE state**, confirming that the Kubernetes control plane is fully operational.

**What this confirms:**
- Control plane managed and monitored by AWS
- Supported Kubernetes version in use
- High availability and fault tolerance handled by AWS
- Cluster ready for workloads and CI/CD deployments

**Why this matters in production:**
- Eliminates manual control-plane management
- Enables consistent environments (dev/stage/prod)
- Forms the backbone for CI/CD, security, and monitoring

---

## 5️⃣ Prometheus – Cluster Metrics Collection

![Prometheus Targets - kube-state-metrics and node-exporter](screenshots/prometheus/prometheus-targets-core.png)

### 🖼️ Prometheus Targets – Cluster State & Node-Level Metrics
**Description:**  
This screenshot shows Prometheus successfully scraping metrics from **kube-state-metrics and node-exporter**, with all targets in an **UP state**.

**What this confirms:**
- Kubernetes object state metrics are available
- Node-level CPU, memory, disk, and network metrics collected
- Service discovery via Kubernetes labels is working

**Why this matters in production:**
- Enables detection of replica mismatches and failed pods
- Supports capacity planning and scaling
- Forms the foundation for alerting and dashboards

---

## 6️⃣ Prometheus – Pod & Container-Level Metrics

![Prometheus Targets - kubelet and cAdvisor](screenshots/prometheus/prometheus-targets-kubelet.png)

### 🖼️ Prometheus Targets – Pod & Container Resource Metrics
**Description:**  
This screenshot shows Prometheus scraping **kubelet, cAdvisor, and probe endpoints** across all nodes.

**What this confirms:**
- Pod- and container-level CPU and memory metrics collected
- Health probe metrics available
- End-to-end observability from node → pod → container

**Why this matters in production:**
- Detects memory leaks and CPU spikes
- Validates resource requests & limits
- Supports incident response and SRE operations

---

## 7️⃣ Grafana – Node & Pod Resource Utilization

![Grafana - Node and Pod Resource Utilization](screenshots/grafana/node-pod-resources.png)

### 🖼️ Grafana Dashboard – Node & Pod Resource Utilization
**Description:**  
This dashboard visualizes **real-time CPU and memory usage** across Kubernetes nodes and pods using Prometheus metrics.

**What this confirms:**
- Metrics are correctly visualized in Grafana
- Resource requests and limits are enforced
- Workload behavior can be monitored over time

**Why this matters in production:**
- Prevents noisy-neighbor issues
- Enables proactive capacity planning
- Ensures workload stability and performance

---

## 8️⃣ Grafana – Cluster Resource Overview

![Grafana - Cluster Resource Overview](screenshots/grafana/cluster-resources.png)

### 🖼️ Grafana Dashboard – Cluster Resource Overview
**Description:**  
This dashboard provides a **cluster-wide summary** of CPU and memory utilization, resource commitments, and namespace-level usage.

**What this confirms:**
- Cluster health is continuously monitored
- Resource over-commitment risks are visible
- Namespace-level usage is tracked

**Why this matters in production:**
- Enables cost optimization and right-sizing
- Prevents resource exhaustion
- Supports scaling and capacity decisions
- Used by platform and SRE teams for reliability

---
## 9️⃣ Kubernetes RBAC – Access Control & Least Privilege

![Kubernetes RBAC - ServiceAccount, Role and RoleBinding](screenshots/kubernetes-security/rbac-jenkins.png)

### 🖼️ Kubernetes RBAC – ServiceAccount, Role & RoleBinding Configuration
**Description:**  
This screenshot shows the **Kubernetes Role-Based Access Control (RBAC)** configuration applied for Jenkins within the cluster, including **ServiceAccounts, Roles, and RoleBindings**.

The commands executed validate that RBAC resources were successfully created and associated within the target namespace, ensuring Jenkins operates with **explicitly defined permissions**.

**What this confirms:**
- A **dedicated ServiceAccount** is created for Jenkins workloads
- A namespace-scoped **Role** defines exactly what actions Jenkins can perform
- A **RoleBinding** securely associates the Role with the ServiceAccount
- Permissions follow the **principle of least privilege**
- RBAC resources are verified using `kubectl get sa,role,rolebinding`

**Why this matters in production:**
- Prevents over-privileged workloads and accidental cluster-wide access
- Reduces blast radius in case of credential compromise
- Enables secure CI/CD interactions with the Kubernetes API
- Meets **security and compliance requirements** in enterprise environments
- Avoids using the default ServiceAccount for sensitive operations

This RBAC setup demonstrates **security-first Kubernetes operations**, where CI/CD systems like Jenkins are granted **only the permissions they need**, a standard practice in **freelance and enterprise DevOps platforms**.

---


## ✅ Summary

These screenshots collectively demonstrate:
- Infrastructure provisioning via **Terraform**
- Secure and scalable networking
- Production-ready **Amazon EKS**
- Deep Kubernetes observability
- Operational maturity and ownership

This level of documentation reflects **real-world freelance and enterprise DevOps delivery**, not a tutorial or demo setup.
