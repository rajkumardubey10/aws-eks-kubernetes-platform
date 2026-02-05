########################
# VPC Outputs
########################

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnets
}

########################
# EKS Outputs
########################

output "cluster_name" {
  description = "EKS Cluster Name"
  value       = module.eks-cluster-application.cluster_name
}

output "cluster_endpoint" {
  description = "EKS Cluster API Server Endpoint"
  value       = module.eks-cluster-application.cluster_endpoint
}

output "cluster_ca_certificate" {
  description = "EKS Cluster CA Certificate"
  value       = module.eks-cluster-application.cluster_certificate_authority_data
  sensitive   = true
}

output "cluster_arn" {
  description = "EKS Cluster ARN"
  value       = module.eks-cluster-application.cluster_arn
}

output "oidc_provider_arn" {
  description = "OIDC Provider ARN (for IRSA)"
  value       = module.eks-cluster-application.oidc_provider_arn
}

