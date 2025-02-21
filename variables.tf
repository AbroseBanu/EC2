variable "region" {
  description = "AWS region where resources will be created"
}

variable "cidr_vpc" {
  description = "CIDR block for the VPC"
}

variable "vpc_name" {
  description = "Name tag for the VPC"
}

variable "cidr_subnet" {
  description = "CIDR block for the subnet"
}

variable "subnet_name" {
  description = "Name tag for the subnet"
}

variable "instance_count" {
  description = "Number of EC2 instances to launch"
  type        = number
}

variable "availability_zone" { # Corrected spelling
  description = "Availability Zone for the subnet"
}

variable "sg_name" {
  description = "Name tag for the security group"
}

variable "instance_type" {
  description = "EC2 instance type"
}

variable "ami" {
  description = "AMI ID for EC2 instances"
}

variable "key_name" {
  description = "Key pair name for SSH access"
}

variable "iname" {
  description = "Base name for the EC2 instances"
}
