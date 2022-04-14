resource "aws_security_group" "web" {
  name        = "${var.component_name}_web_sg"
  description = "Allow ssh inbound traffic from Philo"
  vpc_id      = local.vpc_id

  ingress {
    description = "22 from VPC"
    from_port   = 0
    to_port     =0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    "Name" = "${var.component_name}_web_sg"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "app" {
  name        = "${var.component_name}_app_sg"
  description = "Allow shh inbound traffic from ${aws_security_group.web.id}"
  vpc_id      = local.vpc_id

  ingress {
    description     = "http from VPC"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    "Name" = "${var.component_name}_app_sg"
  }
lifecycle {
    create_before_destroy = true
  }
}



resource "aws_security_group" "lb_sg" {
  name        = "${var.component_name}_lb_sg"
  description = "Allow inbound traffic from everywhere"
  vpc_id      = local.vpc_id

  ingress {
    description     = "http from everywhere"
    from_port       = var.http_port
    to_port         = var.http_port
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description     = "https from everywhere"
    from_port       = var.https_port
    to_port         = var.https_port
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    "Name" = "${var.component_name}_lb_sg"
  }
lifecycle {
    create_before_destroy = true
  }
}
