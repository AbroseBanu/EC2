# AWS EC2 Infrastructure with Terraform

This Terraform project provisions an AWS EC2 environment, including a VPC, subnet, security group, internet gateway, route table, and EC2 instances.

## 🚀 Features
- Creates a **VPC** with a configurable CIDR block.
- Sets up a **subnet** in a specified availability zone.
- Configures an **Internet Gateway** and attaches it to the VPC.
- Creates a **Security Group** allowing SSH (port 22) access.
- Launches multiple **EC2 instances** based on user-defined variables.

## 🛠️ Prerequisites
- **Terraform** installed on your system.
- **AWS CLI** configured with credentials.
- A **valid AWS key pair** for SSH access.

## 📂 File Structure
. 
├── main.tf # Defines AWS resources (VPC, Subnet, EC2, etc.) 
├── variables.tf # Stores all Terraform input variables
├── outputs.tf # Displays EC2 instance IP addresses
├── terraform.tfvars # Defines variable values
└── README.md # Project documentation
