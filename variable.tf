


variable "instancetype" {
  type        = list
  default     = ["t3.micro", "t2.micro", "t2.xlarge"]
  description = "ec2 instance type"
}


variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "region for terraform"
}


variable ip_address {
  type        = list
  default     = ["38.142.134.82/32"]
  description = "an ip address"
}


variable assign_public_ip {
  type        = bool
  default     = true
  description = "public ip"
}

variable create_instance {
  type        = bool
  default     = true
  description = "Create instance"
}
