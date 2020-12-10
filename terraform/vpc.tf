resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr[terraform.workspace]
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.project_name}-${terraform.workspace}"
    Environment = terraform.workspace
  }

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.project_name}-${terraform.workspace}"
    Environment = terraform.workspace
  }
}


resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "${var.project_name}-${terraform.workspace}"
    Environment = terraform.workspace
  }

}

data "aws_availability_zone" "az1" {
  name = "${var.region}a"
}

data "aws_availability_zone" "az2" {
  name = "${var.region}b"
}

resource "aws_subnet" "subnet_a" {
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 10)
  vpc_id            = aws_vpc.vpc.id
  availability_zone = data.aws_availability_zone.az1.name

  tags = {
    Name        = "${var.project_name}-${terraform.workspace}-public-${data.aws_availability_zone.az1.name}"
    Environment = terraform.workspace
  }
}

resource "aws_subnet" "subnet_b" {
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 11)
  vpc_id            = aws_vpc.vpc.id
  availability_zone = data.aws_availability_zone.az2.name

  tags = {
    Name        = "${var.project_name}-${terraform.workspace}-public-${data.aws_availability_zone.az2.name}"
    Environment = terraform.workspace
  }
}