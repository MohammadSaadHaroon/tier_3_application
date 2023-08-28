#public subnet
resource "aws_subnet" "tier_public" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.pub_cidr[count.index]
  availability_zone = var.az[count.index]
  count             = 2

  tags = {
    Name = "3 tier application public subnet"
  }

}
#private subnet
resource "aws_subnet" "tier_private" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "3 tier application private subnet"
  }

}

data "aws_subnets" "sid" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.main_vpc.id]
  }

  tags = {
    Tier = "public"
  }
}