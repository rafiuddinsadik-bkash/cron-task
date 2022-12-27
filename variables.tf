variable "region" {
  default = "us-east-1"
}

variable "subnet_az" {
  default = "us-east-1a"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ec2-name" {
  default = "cron-date"
}

variable "igw_id"{
  default = "igw-94c174ec"
}

variable "eni_private_ip" {
  default = "172.16.10.100"
}
