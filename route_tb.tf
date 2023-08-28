resource "aws_route_table" "tier_rtb" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tier_gw.id
  }

  tags = {
    Name = "3_tier_route_table"
  }
}

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.tier_private.id
  route_table_id = aws_route_table.tier_rtb.id
  count          = 2
}

resource "aws_default_route_table" "adrt" {
  default_route_table_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw.id

  }

  tags = {
    Name = "3_tier_default_route_table"
  }
}