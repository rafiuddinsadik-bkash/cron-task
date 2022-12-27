# data "aws_internet_gateway" "default" {
#   internet_gateway_id = var.igw_id
# }

# resource "aws_route_table" "public" {
#   vpc_id = aws_default_vpc.default.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = data.aws_internet_gateway.default.id
#   }

#   tags = {
#     Name = "public"
#   }
# }

# resource "aws_route_table_association" "public_us_east_1a" {
#   subnet_id      = aws_default_subnet.default_az1.id
#   route_table_id = aws_route_table.public.id
# }
