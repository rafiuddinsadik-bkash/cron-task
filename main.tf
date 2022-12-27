provider "aws" {
    region     = var.region
}


# Generating KeyPair for Accessing DB
resource "tls_private_key" "dbkey" {
  algorithm = "RSA"
}
resource "local_file" "myterrakey" {
  content  = tls_private_key.dbkey.private_key_pem
  filename = "crontab_kp.pem"
}
resource "aws_key_pair" "dbkp" {
  key_name   = "crontab_kp"
  public_key = tls_private_key.dbkey.public_key_openssh
}

resource "aws_instance" "ec2_demo" {

  ami  = "ami-0b5eea76982371e91" #amazon linux 2
  instance_type = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.cron_inst_profile.name
  
  network_interface {
    network_interface_id = aws_network_interface.cron-eni.id
    device_index         = 0
  }


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