#Vars

variable "region" {
  default = "us-east-1"
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
