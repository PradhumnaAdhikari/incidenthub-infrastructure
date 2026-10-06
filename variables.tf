variable "aws_region" {
  description = "AWS region where IncidentHub infrastructure will be created"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the IncidentHub EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the IncidentHub VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the IncidentHub public subnet"
  type        = string
}
variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}