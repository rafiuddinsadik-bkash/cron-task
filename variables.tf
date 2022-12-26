#Vars

variable "region" {}

variable "ami" {
  description = "Amazon Linux AMI"
}

variable "instance_type" {}

variable "ec2" {
  description = "EC2 instance"
  type        = string
  default     = null
  
}
