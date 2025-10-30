variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.10.0.0/16"
}

variable "subnets" {
  description = "List of public subnets"
  type = list(object({
    name = string
    az   = string
    cidr = string
  }))
}

variable "igw_name" {
  description = "Internet Gateway name"
  type        = string
}

variable "rt_name" {
  description = "Route table name"
  type        = string
}