terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_vpc" "demo_vpc_01" {
    cidr_block = "10.0.0.0/16"

    tags = {
      Name = "demo_vpc"
    }
}

resource "aws_subnet" "public_subnet_01" {
  vpc_id = aws_vpc.demo_vpc_01.id
  cidr_block = "10.0.0.0/24"

  tags = {
      Name = "public_subnet"
    }
}

resource "aws_subnet" "private_subnet_01" {
  vpc_id = aws_vpc.demo_vpc_01.id
  cidr_block = "10.0.1.0/24"

    tags = {
      Name = "private_subnet"
    }

}

resource "aws_internet_gateway" "demo_igw_01" {
  vpc_id = aws_vpc.demo_vpc_01.id
}

resource "aws_route_table" "public_rtb_01" {
  vpc_id = aws_vpc.demo_vpc_01.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo_igw_01.id
  }
}

resource "aws_route_table_association" "public_subnet_01" {
  subnet_id = aws_subnet.public_subnet_01.id
  route_table_id = aws_route_table.public_rtb_01.id
}
