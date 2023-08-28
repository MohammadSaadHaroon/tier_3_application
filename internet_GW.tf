resource "aws_internet_gateway" "tier_gw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "3_tier_igw"
  }

}