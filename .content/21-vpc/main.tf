terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
# provider "aws" {
#   region  = "eu-central-1"
#   shared_config_files      = ["~/.aws/config"]
#   shared_credentials_files = ["~/.aws/credentials"]
#   profile                  = "sheral"
# }

provider "aws" {
  region                  = "eu-central-1"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                 = "sheral"
}

resource "aws_vpc" "dee-vpc-02" {
  cidr_block = "10.0.0.0/16"

  tags = {
    env = "dee"
    Name = "main"
  }
  }
}


resource "aws_subnet" "dee-public-subnet" {
  vpc_id     = aws_vpc.dee-vpc-02.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "dee-private-subnet" {
  vpc_id     = aws_vpc.dee-vpc-02.id
  cidr_block = "10.0.2.0/24"
}


resource "aws_internet_gateway" "dee-igw-01" {
  vpc_id = aws_vpc.dee-vpc-02.id
}


resource "aws_route_table" "dee-public-rt" {
  vpc_id = aws_vpc.dee-vpc-02.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dee-igw-01.id
  }
}

resource "aws_route_table_association" "dee-rt-association" {
  subnet_id      = aws_subnet.dee-public-subnet.id
  route_table_id = aws_route_table.dee-public-rt.id
}

