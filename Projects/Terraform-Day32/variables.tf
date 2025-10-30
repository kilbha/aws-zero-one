variable "kub_version" {
    default = 1.29
    description = "Kubernetes Version"  
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
    description = "VPC CIDR Range"
}

variable "aws_region" {
    default = "us-east-1"
    description = "AWS Region -- North Virginia"
}

variable "vpc_pvt_subnets" {
    default = ["10.0.1.0/24", "10.0.2.0/24"]
    description = "VPC private subnets"  
}

variable "vpc_pub_subnets" {
    default = ["10.0.4.0/24", "10.0.5.0/24"]
    description = "VPC public subnets"      
}
