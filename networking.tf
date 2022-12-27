resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_default_subnet" "def_subnet" {
  availability_zone = var.subnet_az
  cidr_block        = "172.16.10.0/24"
  tags = {
    Name = "cron-subnet"
  }
}

resource "aws_network_interface" "cron-eni" {
  subnet_id   = aws_default_subnet.def_subnet.id
  private_ips = [eni_private_ip]

  tags = {
    Name = "crontab-eni"
  }
}

resource "aws_security_group" "ec2-SG" {

  description = "HTTP, SSH"
  name = "SG-CronTab-DateEC2"
  vpc_id = aws_default_vpc.default.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "output from webserver"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
