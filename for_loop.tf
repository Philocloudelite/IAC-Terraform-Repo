
resource "aws_instance" "web" {
  for_each = toset(var.instancetype)
  ami                         = data.aws_ssm_parameter.ami.value
  instance_type               = each.value
  associate_public_ip_address = var.assign_public_ip
  user_data                   = file("${path.module}/app1-http.sh")
  vpc_security_group_ids      = [aws_security_group.allow_http.id]

  tags = {
    Name = "web-${each.value}"
  }
}

