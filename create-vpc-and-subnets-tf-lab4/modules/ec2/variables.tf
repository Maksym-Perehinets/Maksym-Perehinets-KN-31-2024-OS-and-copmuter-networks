variable "ami" {
  type = string
}

variable "key_pair" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "allow_ssh_security_group" {
  type = list(string)
}


variable "private_subnet_id" {
  type = string
}

variable "allow_local_security_group" {
  type = list(string)
}