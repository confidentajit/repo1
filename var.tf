variable "region" {
  default= "us-east-1"
}
variable "ami_id" {

  default = "ami-0947bcdf4c0dff375"
  
}
variable "key_name" {
  default = "Ajit-personal"
}

variable "instance_type" {

  default = "t2.micro"
}

variable "subnets" {

  default = "subnet-917956ce"
}

variable "azs" {

  default = "us-east-1a"
}

variable "security_grpup_id" {

  default = "sg-0873cdfb93e71ab20"
}