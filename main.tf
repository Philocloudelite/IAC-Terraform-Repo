
data "aws_ami" "golden_ami" {
  
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

 
 resource "random_integer" "random" {
  min = 1
  max = 100
 }
data "aws_ssm_parameter" "ami" {
  name = "lastest_golden_ami"
}
variable "port_http" {
  default = 80
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow http inbound traffic"
  #vpc_id      = aws_vpc.main.id

  ingress {
    description = "http from VPC"
    from_port   = var.port_http
    to_port     = var.port_http
    protocol    = "tcp"
    cidr_blocks = var.ip_address
  }
  ingress {
    description = "ssh from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ip_address
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

}
# count is mostly used for conditions

resource "aws_instance" "web" {
  count = var.create_instance ? 1 : 0
  ami                         = data.aws_ssm_parameter.ami.value
  instance_type               = var.instancetype
  associate_public_ip_address = var.assign_public_ip
  user_data                   = file("${path.module}/app1-http.sh")
  vpc_security_group_ids      = [aws_security_group.allow_http.id]

  tags_all = {
    Name = "web-${random_integer.random.id}"
  }
}
