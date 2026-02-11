
## VPC MODULE SETUP 
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.0"

  name = "eks-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  map_public_ip_on_launch = true

  enable_nat_gateway = true
  single_nat_gateway  = true
  
  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"               = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"       = "1"
  }

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

## EKS AUTO MODE CLUSTER SETUP
module "eks-cluster-application" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.15.1"
  
  create_node_iam_role = true
  create_iam_role      = true

  name = var.cluster_name
  kubernetes_version = "1.32"
  
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_irsa = true

  endpoint_public_access = true
  enable_cluster_creator_admin_permissions = true

  create_auto_mode_iam_resources = true
  compute_config = {
    enabled = true
    node_pools = ["general-purpose"]
  }
  
  tags = {
    Terraform = "true"
  }

}