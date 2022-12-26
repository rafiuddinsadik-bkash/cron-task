# Creating an Internet Gateway for the VPC

resource "aws_internet_gateway" "igw" {
  
  # VPC in which it has to be created!
  vpc_id = aws_default_vpc.default.id

  tags = {
    Name = "IG"
  }
}