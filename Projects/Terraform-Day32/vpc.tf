provider "aws" {
    region = var.aws_region  
}

data "aws_availability_zones" "available" {}

locals {
  cluster_name = "kilbha-eks-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
    length = 8
    special = false
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.7.0"

  name = "kilbha-eks-vpc"
  cidr = var.vpc_cidr
  azs = data.aws_availability_zones.available.names
  private_subnets = var.vpc_pvt_subnets
  public_subnets = var.vpc_pub_subnets
  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true
  enable_dns_support = true


  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb" = "1"
  }
}