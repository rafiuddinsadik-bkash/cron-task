resource "aws_route_table" "public" {
  vpc_id = aws_default_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public"
  }
}



resource "aws_route_table_association" "public_us_east_1a" {
  subnet_id      = aws_default_subnet.default_az1.id
  route_table_id = aws_route_table.public.id
}
