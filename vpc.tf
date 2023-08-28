#VPC resource
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "3_tier_VPC"
  }

}