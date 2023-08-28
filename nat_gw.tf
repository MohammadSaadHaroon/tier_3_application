resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.tier_eip.id
  subnet_id     = aws_subnet.tier_public[0].id

  tags = {
    Name = "Tier_nat_gw"
  }

  depends_on = [aws_internet_gateway.tier_gw]

}