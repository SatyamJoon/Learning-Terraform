# Create aws vpc

resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block_vpc
  instance_tenancy = var.instance_tenancy

  tags = {
    Name = var.Name_vpc
  }
}

# create aws public subnet

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.cidr_block_public_subnet
  availability_zone = var.availability_zone_public_subnet

  tags = {
    Name = var.Name_public_subnet
  }
}

# create aws private subnet

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.cidr_block_private-subnet
  availability_zone = var.availability_zone_private_subnet

  tags = {
    Name = var.Name_private_subnet
  }
}

# create internet gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.Name_Internet_Gateway
  }
}

# create a public route table

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.cidr_block_public_route_table
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = var.Name__public_route_table
  }
}

# associate route table

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Create elastic ip address

resource "aws_eip" "lb" {
  domain   = var.domain

  tags = {
    Name= var.Name_elastic_ip_address
  }
}

# Create NAT gateway

resource "aws_nat_gateway" "example" {
  subnet_id     = aws_subnet.public.id
  allocation_id = aws_eip.lb.id

  tags = {
    Name = var.Name_NAT_gateway
  }
}

# create a private route table

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.cidr_block_private_route_table
    gateway_id = aws_nat_gateway.example.id
  }

  tags = {
    Name = var.Name_private_route_table
  }
}

# associate route table

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

# create instance in public subnet

resource "aws_instance" "public_instance" {
  ami           = var.ami_instance_public_subnet             # Replace with ur region ami id
  instance_type = var.instance_type_instance_public_subnet
  key_name = var.key_name__instance_public_subnet
  subnet_id = aws_subnet.public.id
  associate_public_ip_address = true
  

  tags = {
    Name = var.Name_instance_public_subnet
  }
}

resource "aws_instance" "private_instance" {
  ami           = var.ami_instance_private_subnet         # Replace with ur region ami id
  instance_type = var.instance_type_instance_private_subnet
  key_name = var.key_name_instance_private_subnet
  subnet_id = aws_subnet.private.id
  associate_public_ip_address = false
  

  tags = {
    Name = var.Name_instance_private_subnet
  }
}