
resource "aws_instance" "ec2_demo" {

  ami  = "ami-0b5eea76982371e91"
  instance_type = var.instance_type
  subnet_id = aws_default_subnet.default_az1.id

  root_block_device {
    volume_type = "gp2"
    volume_size = "100"
  }

  vpc_security_group_ids = [aws_security_group.ec2-SG.id]
  associate_public_ip_address = false

  tags = {
   Name = var.ec2-name
  }

}



