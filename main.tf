# Define the AWS provider and set the region from variables
provider "aws" {
    region = var.region
}

# Create a Virtual Private Cloud (VPC) with the specified CIDR block
resource "aws_vpc" "my_vpc" {
    cidr_block = var.cidr_vpc

    tags = {
        Name = var.vpc_name
    }
}

# Create a subnet within the VPC
resource "aws_subnet" "my_subnet" {
    vpc_id                  = aws_vpc.my_vpc.id
    cidr_block              = var.cidr_subnet
    map_public_ip_on_launch = true
    availability_zone       = var.availabilty_zone

    tags = {
        Name = var.subnet_name
    }
}

# Define a security group for the EC2 instance
resource "aws_security_group" "my_sg" {
    vpc_id = aws_vpc.my_vpc.id
    name   = "sg-1"

    # Allow inbound SSH access from any IP (consider restricting this for security)
    ingress = [{
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]  # Security risk: Allows SSH access from anywhere
    }]

    # Allow all outbound traffic
    egress = [{
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }]

    tags = {
        Name = var.sg_name
    }
}

# Create an Internet Gateway (IGW) to enable internet access for the VPC
resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc.id

    tags = {
        Name = "my-igw"
    }
}

# Create a Route Table to define traffic routes for the subnet
resource "aws_route_table" "my_route_table" {
    vpc_id = aws_vpc.my_vpc.id

    # Add a default route to send all traffic to the internet gateway
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_igw.id
    }

    tags = {
        Name = "Myroutetable"
    }
}

# Associate the route table with the subnet to enable internet access
resource "aws_route_table_association" "my_route_table_association" {
    subnet_id      = aws_subnet.my_subnet.id
    route_table_id = aws_route_table.my_route_table.id
}

# Create EC2 instances based on the given count
resource "aws_instance" "example" {
    count                  = var.instance_count
    ami                    = var.ami
    instance_type          = var.instance_type
    key_name               = var.key_name
    subnet_id              = aws_subnet.my_subnet.id
    vpc_security_group_ids = [aws_security_group.my_sg.id]

    # Set instance tags with a dynamic name based on count index
    tags = {
        Name = "${var.iname}-${count.index + 1}"
    }

    # Define the root block device settings
    root_block_device {
        volume_size = 15
        volume_type = "gp2"
    }
}
