# aws region as Oregon
provider "aws" {
  region = "us-west-2"
}

# creating vpc
resource "aws_vpc" "main" {
  cidr_block       = "15.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name       = "terraform_vpc"
  }
}

# Creating internet gateway and attching to above created VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "terraform_IGW"
  }
}

# Adding the internet gateway route to main route table
resource "aws_default_route_table" "example" {
  default_route_table_id = aws_vpc.main.main_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
