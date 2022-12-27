provider "aws" {
    region     = var.region
}

resource "aws_instance" "ec2_demo" {

  ami  = "ami-0b5eea76982371e91" #amazon linux 2
  instance_type = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.cron_inst_profile.name
  
  subnet_id = aws_default_subnet.def_subnet.id

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

module "ssm-vpc-endpoint" {
  source  = "bayupw/ssm-vpc-endpoint/aws"
  version = "1.0.1"
  
  vpc_id = aws_default_vpc.default.id
  vpc_subnet_ids = aws_default_subnet.def_subnet.id
  custom_ingress_cidrs = ["0.0.0.0/0"]
}