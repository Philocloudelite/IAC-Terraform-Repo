
locals {
  mandatory_tag = {
    line_of_business        = "hospital"
    ado                     = "max"
    tier                    = "WEB"
    operational_environment = upper(terraform.workspace)
    tech_poc_primary        = "udu.udu25@gmail.com"
    tech_poc_secondary      = "udu.udu25@gmail.com"
    application             = "http"
    builder                 = "udu.udu25@gmail.com"
    application_owner       = "kojitechs.com"
    vpc                     = "WEB"
    cell_name               = "WEB"
    component_name          = "IAC-TERRAFORM-REPO"

  }
  vpc_id = aws_vpc.Kojitechs.id
}

resource "aws_vpc" Kojitechs {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = false
  enable_dns_hostnames = false

  tags = {
    "Name" = "kojitechs"
  }
}

 resource "aws_internet_gateway" "igw" {
  vpc_id = local.vpc_id

  tags = {
    "Name" = "kojitechs_igw"
  }
}

# creating public subnet
resource "aws_subnet" public_subnet1 {
  vpc_id     = local.vpc_id
  cidr_block = var.cidr_pubsubnet[0]
  map_public_ip_on_launch = true 
  availability_zone = var.pub_az[0]

  tags = {
    "Name" = "public_subnet1"
  }

} 

resource "aws_subnet" public_subnet2 {
  vpc_id     = local.vpc_id
  cidr_block = var.cidr_pubsubnet[1]
  map_public_ip_on_launch = true 
  availability_zone = var.pub_az[1]

  tags = {
    "Name" = "public_subnet2"
  }
} 

#creating private subnet
resource "aws_subnet" priv_sub1 {
  vpc_id     = local.vpc_id
  cidr_block = var.cidr_privsubnet[0]
  availability_zone = var.priv_sub[0] 

   tags = {
    "Name" = "priva-sub1-${var.priv_sub[0]}"
  }

} 

resource "aws_subnet" priv_sub2 {
  vpc_id     = local.vpc_id
  cidr_block = var.cidr_privsubnet[1]
  availability_zone = var.priv_sub[1]

  tags = {
    "Name" = "priva-sub2-${var.priv_sub[1]}"
  }
} 

# creating dababase subnet
resource "aws_subnet" database_sub1 {
  vpc_id     = local.vpc_id
  cidr_block = var.cidr_database[0]
  availability_zone = var.database_sub[0]

  tags = {
    "Name" = "database_sub1-${var.priv_sub[0]}"
  }
} 

resource "aws_subnet" database_sub2 {
  vpc_id     = local.vpc_id
  cidr_block = var.cidr_database[1]
  availability_zone = var.database_sub[1]

  
  tags = {
    "Name" = "database_sub2-${var.priv_sub[1]}"
  }
}
# creating routs

resource "aws_route_table" "pub_rt1" {

  vpc_id = local.vpc_id

  route { 
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

}

resource "aws_route_table" "pub_rt2" {
  vpc_id = local.vpc_id

    route  { 
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# rout table association
resource "aws_route_table_association" "pub_rt_assoc1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.pub_rt1.id
}
resource "aws_route_table_association" "pub_rt_assoc2" {
  subnet_id     = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.pub_rt2.id
}

# creating the default route table
resource "aws_default_route_table" "default_route" {
  default_route_table_id = aws_vpc.Kojitechs.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw_1.id
  }
}

resource "aws_eip" "eip" {
  vpc      = true
  depends_on = [aws_internet_gateway.igw]
    
}

# creating nat gateway
resource "aws_nat_gateway" "ngw_1" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnet1.id

  depends_on = [aws_internet_gateway.igw]

    tags = {
    Name = "gw_NAT"
  }
}