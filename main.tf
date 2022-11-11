terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_vpc" "sofia" {
  cidr_block = "10.0.0.0/27"
  tags = {
    "Name" = "sofiaNaer-dev-vpc"
  }
}
resource "aws_subnet" "Subnet_S" {
  vpc_id     = aws_vpc.sofia.id
  cidr_block = "10.0.0.0/27"
  tags = {
    "Name" = "sofiaNaer-k8s-subnet"
  }

}
resource "aws_internet_gateway" "Sofia_GW" {
  vpc_id = aws_vpc.sofia.id

  tags = {
    Name = "SofiaNaer_GW"
  }
}

resource "aws_route" "routeIGW" {
  route_table_id         = aws_vpc.sofia.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.Sofia_GW.id
}
