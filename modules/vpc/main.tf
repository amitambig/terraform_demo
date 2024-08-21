resource "aws_vpc" "my_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "MyVPC"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}
#subnets
resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  count = length(var.subnets_name)
  cidr_block = var.subnets_cidr[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnets_name[count.index]
  }
}

#IGW
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "MyIGW"
  }
}

#RT
resource "aws_route_table" "my_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "PublicRT"
  }
}

#RT association
resource "aws_route_table_association" "a" {
    count = 2
  subnet_id      = aws_subnet.subnet[count.index].id
  route_table_id = aws_route_table.my_rt.id
}