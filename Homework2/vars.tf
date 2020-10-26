terraform {
    required_version = ">= 0.12.0"
  }
  
  variable "aws_region" {
    description = "AWS region"
    default     = "us-east-1"
  }

  variable "machine_type"{
    description = "AMI type"
    default     = "t2.medium"
  }
  

variable "cidr_block" {
  default     = "10.0.0.0/16"
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr_blocks" {
  default     = ["10.0.0.0/24", "10.0.2.0/24"]
  type        = list
  description = "List of public subnet CIDR blocks"
}

variable "private_subnet_cidr_blocks" {
  default     = ["10.0.1.0/24", "10.0.3.0/24"]
  type        = list
  description = "List of private subnet CIDR blocks"
}

variable "availability_zones" {
  default     = ["us-east-1a", "us-east-1b"]
  type        = list
  description = "List of availability zones"
}
  variable "key_pair"{
    default    ="ansible_key"
  }
