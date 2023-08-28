#VPC cidr variable
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "pub_cidr" {
  type    = list(any)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "az" {
  type    = list(any)
  default = ["us-east-1a", "us-east-1b"]
}

variable "ec2_ami" {
  default = "ami-051f7e7f6c2f40dc1"
}

variable "ec2_type" {
  default = "t2.micro"
}

variable "ec2_keypair" {
  default = "web_tier_key_pair"
}