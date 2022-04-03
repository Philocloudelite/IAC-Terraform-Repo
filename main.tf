
resource "aws_vpc" Kojitechs {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = false
  enable_dns_hostnames = false
}

resource "aws_subnet" public_subnet1 {
  vpc_id     = local.vpc_id
  cidr_block = var.cidr_pubsubnet[0]
  map_public_ip_on_launch = true 
  availability_zone = var.pub_az[0]
} 

resource "aws_subnet" public_subnet2 {
  vpc_id     = local.vpc_id
  cidr_block = var.cidr_pubsubnet[1]
  map_public_ip_on_launch = true 
  availability_zone = var.pub_az[1]
} 

resource "aws_subnet" priv_sub1 {
  vpc_id     = local.vpc_id
  cidr_block = var.cidr_privsubnet[0]
  availability_zone = var.priv_sub[0]
} 

resource "aws_subnet" priv_sub2 {
  vpc_id     = local.vpc_id
  cidr_block = var.cidr_privsubnet[1]
  availability_zone = var.priv_sub[0]
} 

resource "aws_subnet" database_sub1 {
  vpc_id     = local.vpc_id
  cidr_block = var.cidr_database[0]
  availability_zone = var.database_sub[0]
} 

resource "aws_subnet" database_sub2 {
  vpc_id     = local.vpc_id
  cidr_block = var.cidr_database[1]
  availability_zone = var.database_sub[1]
}