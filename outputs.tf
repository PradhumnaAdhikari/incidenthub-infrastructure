output "vpc_id" {
  description = "ID of the IncidentHub VPC"
  value       = aws_vpc.incidenthub.id
}

output "public_subnet_id" {
  description = "ID of the IncidentHub public subnet"
  value       = aws_subnet.public.id
}

output "instance_id" {
  description = "ID of the IncidentHub EC2 instance"
  value       = aws_instance.incidenthub.id
}

output "public_ip" {
  description = "Public IP address of the IncidentHub EC2 instance"
  value       = aws_instance.incidenthub.public_ip
}

output "private_ip" {
  description = "Private IP address of the IncidentHub EC2 instance"
  value       = aws_instance.incidenthub.private_ip
}
