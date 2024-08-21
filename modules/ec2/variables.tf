variable "instances_name" {
  default = ["Webserver1","Webserver2"]
}
variable "subnet_id" {
  type = list(string)
}
variable "sg_id" {
  
}