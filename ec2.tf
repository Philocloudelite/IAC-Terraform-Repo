
locals {
  subnet_id              = [aws_subnet.public_subnet[0].id, aws_subnet.priv_sub[0].id]
  Name                   = ["web_instance", "app_instance"]
  vpc_security_group_ids = [aws_security_group.web.id, aws_security_group.app.id]
}

# output "public_ip" {
#   value = format("http://%s", aws_instance.web[0].public_ip)
# }

data "aws_secretsmanager_secret_version" "mysecret" {
  secret_id     = module.aurora.secrets_version.secret_id
}


data "aws_ami" "amzlinux2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}



resource "aws_instance" "web" {
  ccount                = var.create_instance ? length(local.Name) : 0
  ami                    = "ami-0c02fb55956c7d316" # use datasource to fetch
  instance_type          = "t2.micro"
  subnet_id              = local.subnet_id[count.index]
  user_data              = file("${path.module}/template/app1-http.sh")
  vpc_security_group_ids = [local.vpc_security_group_ids[count.index]]
  iam_instance_profile   = aws_iam_instance_profile.instance_profile.name
  key_name               = aws_key_pair.bastion_instance.id

  tags = {
    Name = local.Name[count.index]
  }
}

resource "aws_key_pair" "bastion_instance" {
  key_name   = "bastion_instance"
  public_key = file("C:\\Users\\Owner\\.ssh\\bastion_instance.pub")
}

resource "aws_ssm_parameter" "ssm_kp" {
  name  = format("%s-%s", var.component-name, "ssm-kp")
  type  = "SecureString"
  value = " "
  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "aws_lb_target_group_attachment" "test" {
  count             = var.create_instance ? length(local.Name) : 0
  target_group_arn = aws_lb_target_group.kojitechs_tg.arn
  target_id        = aws_instance.web[count.index].id
  port             = var.app_port
}