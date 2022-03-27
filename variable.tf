


variable "instancetype" {
  type        = string
  default     = "t3.micro"
  description = "ec2 instance type"
}


variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "region for terraform"
}
