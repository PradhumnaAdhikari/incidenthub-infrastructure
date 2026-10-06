terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  required_version = ">= 1.0"
}

provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "incidenthub" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "incidenthub-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.incidenthub.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "incidenthub-public-subnet"
  }
}

resource "aws_internet_gateway" "incidenthub" {
  vpc_id = aws_vpc.incidenthub.id

  tags = {
    Name = "incidenthub-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.incidenthub.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.incidenthub.id
  }

  tags = {
    Name = "incidenthub-public-route-table"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_instance" "incidenthub" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.incidenthub.id]
  #iam_instance_profile   = aws_iam_instance_profile.ec2.name
  tags = {
    Name = "incidenthub-server"
  }
}
resource "aws_security_group" "incidenthub" {
  name        = "incidenthub-security-group"
  description = "Security group for IncidentHub EC2"
  vpc_id      = aws_vpc.incidenthub.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "incidenthub-security-group"
  }
}
