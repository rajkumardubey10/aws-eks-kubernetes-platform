# 🚀 Production-Grade Jenkins CI/CD Platform on AWS EKS

---

## 1️⃣ Project Overview

This repository showcases a **production-ready DevOps platform** built and delivered in a **freelance consulting style**.  
The project demonstrates **end-to-end ownership** of infrastructure, CI/CD, Kubernetes security, governance, and observability on **AWS EKS**.

The solution is designed to meet **real client requirements**, including:
- High availability
- Security by default
- Controlled resource usage
- Zero-trust networking
- Full monitoring and visibility

---

## 2️⃣ Architecture Overview

**High-level flow:**

1. Infrastructure provisioned using **Terraform**
2. Amazon EKS cluster deployed in a custom VPC
3. Jenkins CI/CD pipelines for build and deployment
4. Kubernetes workloads secured with **RBAC**
5. **Kyverno** policies enforce governance rules
6. **NetworkPolicies** enforce zero-trust communication
7. **Prometheus & Grafana** provide monitoring and observability

This mirrors how real production platforms are delivered to clients.

---

## 3️⃣ Technology Stack

- **Cloud**: AWS (EKS, EC2, IAM, VPC, ALB, EBS)
- **Infrastructure as Code**: Terraform (remote backend)
- **CI/CD**: Jenkins
- **Containerization**: Docker
- **Orchestration**: Kubernetes
- **Security & Governance**: Kyverno, RBAC, NetworkPolicies
- **Monitoring**: Prometheus, Grafana

---

## 4️⃣ Key Design Decisions

- **Terraform remote backend** for safe state management
- **EKS** for managed Kubernetes control plane
- **Jenkins** for flexible CI/CD pipelines
- **Kyverno** for policy-as-code enforcement
- **Resource requests & limits** to prevent over-consumption
- **Zero-trust networking** using NetworkPolicies
- **Observability first** with Prometheus and Grafana

These decisions align with **enterprise and client production standards**.

---

## 5️⃣ Docker Best Practices

📂 `docker/`

### Implemented:
- Multi-stage Docker builds
- Minimal final image size
- Non-root container execution
- Reduced attack surface

This ensures **secure and efficient container images** suitable for production workloads.

---

## 6️⃣ Infrastructure as Code (Terraform – AWS EKS)

📂 `eks/`

### Capabilities:
- Remote backend using **Amazon S3**
- Custom VPC and subnets
- Amazon EKS cluster provisioning
- IAM roles, OIDC provider, and IRSA support

### 📸 Screenshot: Terraform Remote Backend (S3)
**Description:**  
Shows Terraform storing the `terraform.tfstate` file in an S3 bucket with locking enabled.  
This enables **safe collaboration, state consistency, and auditability**, which is essential for client projects.

![Terraform Backend](screenshots/aws-terraform/terraform-backend.png)

---

### 📸 Screenshot: VPC and Subnet Configuration
**Description:**  
Displays the custom VPC and multiple subnets created for the EKS cluster across Availability Zones, ensuring **high availability and fault tolerance**.

![VPC](screenshots/aws-terraform/vpc-subnets.png)

---

### 📸 Screenshot: Amazon EKS Cluster Status
**Description:**  
Shows the active EKS cluster provisioned via Terraform, confirming successful **Infrastructure as Code execution**.

![EKS Cluster](screenshots/aws-terraform/eks-cluster.png)

---

### 📸 Screenshot: Terraform Apply Output
**Description:**  
Demonstrates a successful Terraform apply, validating **repeatable and production-safe infrastructure provisioning**.

![Terraform Apply](screenshots/aws-terraform/terraform-apply.png)

---

## 7️⃣ Kubernetes Manifests & RBAC

📂 `kubernetes/`

### Kubernetes Manifests
📂 `kubernetes/k8s-manifests/`
- Deployments
- Services
- StatefulSets

### RBAC
📂 `kubernetes/rbac/`
- ServiceAccounts
- Roles
- RoleBindings

RBAC is implemented using **least-privilege access**, which is mandatory in production clusters.

---

## 8️⃣ Kubernetes Security & Governance (Kyverno)

📂 `kyverno-policies/`

### Policies Enforced:
1. Docker images must not use the `latest` tag
2. Minimum replicas ≥ 2 for high availability
3. CPU and memory requests & limits are mandatory
4. StatefulSets must define `volumeClaimTemplates`

### 📸 Screenshot: Kyverno Policy Enforcement
**Description:**  
Shows Kyverno validating and enforcing policies before workloads are admitted into the cluster.  
This prevents misconfigurations and enforces **platform-level governance**.

![Kyverno](screenshots/kubernetes-security/kyverno-policy.png)

---

## 9️⃣ Network Security (Zero-Trust Model)

📂 `network-policies/`

### Network Rules:
- Default deny-all policy
- Frontend → Backend allowed
- Backend → Database allowed
- Frontend → Database blocked

This enforces **strict service-to-service communication** and follows a **zero-trust security model**.

### 📸 Screenshot: NetworkPolicy Enforcement
**Description:**  
Illustrates controlled pod-to-pod communication, ensuring frontend services cannot directly access the database.

![NetworkPolicy](screenshots/kubernetes-security/network-policy.png)

---

## 🔟 CI/CD Pipelines (Jenkins)

📂 `jenkins/`

### CI Pipeline Responsibilities:
- Source code checkout
- Docker image build
- Image tagging and push

### CD Pipeline Responsibilities:
- Kubernetes manifest validation
- Deployment to EKS
- Controlled rollout strategy

### 📸 Screenshot: Jenkins CI Pipeline
**Description:**  
Shows a successful Jenkins CI pipeline execution performing image build and push operations.

![Jenkins CI](screenshots/jenkins/ci-pipeline.png)

---

### 📸 Screenshot: Jenkins CD Pipeline
**Description:**  
Displays the Jenkins CD pipeline deploying applications into the EKS cluster in an automated and repeatable manner.

![Jenkins CD](screenshots/jenkins/cd-pipeline.png)

---

## 1️⃣1️⃣ Ingress & Storage Integration

### Implemented:
- **AWS ALB Ingress Controller** for external traffic
- **EBS CSI Driver** for dynamic volume provisioning
- Persistent storage for StatefulSets

This setup supports **stateful production workloads**.

---

## 1️⃣2️⃣ Monitoring & Observability

📂 `monitoring/`

### Prometheus
- Node Exporter
- kube-state-metrics
- ServiceMonitors

### Grafana
- Cluster dashboards
- Node-level metrics
- Pod-level resource usage

---

### 📸 Screenshot: Prometheus Targets
**Description:**  
Shows Prometheus targets in an **UP state**, confirming successful metric scraping from Kubernetes components.

![Prometheus](screenshots/prometheus/targets.png)

---

### 📸 Screenshot: Grafana Node Dashboard
**Description:**  
Displays CPU and memory utilization across cluster nodes, enabling **capacity planning and performance analysis**.

![Grafana Nodes](screenshots/grafana/node-dashboard.png)

---

### 📸 Screenshot: Grafana Pod Resource Usage
**Description:**  
Shows per-pod CPU and memory usage, validating enforcement of Kubernetes **resource requests and limits**.

![Grafana Pods](screenshots/grafana/pod-usage.png)

---

## 1️⃣3️⃣ Screenshots & Execution Proof

📂 `screenshots/`

This folder contains categorized screenshots for:
- AWS & Terraform
- Jenkins CI/CD
- Prometheus
- Grafana

All screenshots are captured from a **real AWS EKS environment**, not simulated data.

---

## 1️⃣4️⃣ Freelancing Experience Justification

This project reflects how I deliver **end-to-end DevOps platforms** for freelance clients:
- Infrastructure ownership
- Secure CI/CD pipelines
- Kubernetes governance and policy enforcement
- Zero-trust networking
- Full monitoring and observability

This repository represents **3+ years of hands-on freelancing experience** condensed into a single, production-accurate project.

---

## 1️⃣5️⃣ Key Learnings & Challenges

- Designing secure Kubernetes platforms
- Enforcing governance at scale
- Balancing resource efficiency and availability
- Operating production-ready EKS clusters

---

## 1️⃣6️⃣ Future Enhancements

- Horizontal Pod Autoscaler (HPA)
- GitOps with ArgoCD
- Secrets management with AWS Secrets Manager
- Cost optimization dashboards

---

## 1️⃣7️⃣ License

MIT License

---

## 1️⃣8️⃣ Contact

For discussions around architecture, freelancing delivery models, or DevOps consulting, feel free to connect.
