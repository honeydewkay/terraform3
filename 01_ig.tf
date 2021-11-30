resource "aws_internet_gateway" "sdkim_ig" {
  vpc_id = aws_vpc.sdkim_vpc.id

  tags = {
    "Name" = "${var.name}-ig"
  }
}

resource "aws_route_table" "sdkim_rt" {
  vpc_id = aws_vpc.sdkim_vpc.id
  route {
      cidr_block = var.cidr_route
      gateway_id = aws_internet_gateway.sdkim_ig.id
  }
  tags = {
      "Name" = "${var.name}-rt"
  }
}

resource "aws_route_table_association" "sdkim_igass_pub" {
  count = 2
  subnet_id      = aws_subnet.sdkim_pub[count.index].id
  route_table_id = aws_route_table.sdkim_rt.id
}