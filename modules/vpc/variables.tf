variable "vpc_cidr" {
  
}
variable "subnets_cidr" {
  type = list(string)
}

variable "subnets_name" {
  default = ["Public Subnet1","Public Subnet2"]
}