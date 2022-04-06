
variable aws_region {
  type        = string
  default     = "us-east-1"
  description = "aws region"
}

variable cidr_pubsubnet {
  type        = list
  default     = ["10.0.0.0/24", "10.0.2.0/24"]
  description = "list of public cidrs "
}

variable cidr_privsubnet {
  type        = list
  default     = ["10.0.1.0/24","10.0.3.0/24"]
  description = "list of private cidrs"
}

variable cidr_database {
  type        = list
  default     = ["10.0.5.0/24","10.0.7.0/24"]
  description = "list of database cidrs"
}

variable pub_az {
  type        = list
  default     = ["us-east-1a","us-east-1b"]
  description = " list of public az's "
}

variable priv_sub {
  type        = list
  default     = ["us-east-1c","us-east-1a"]
  description = " list of private az's "
} 

variable database_sub {
  type        = list
  default     = ["us-east-1b","us-east-1c"]
  description = " list of database az's "
}

variable "pub_main_rt" {
  
}