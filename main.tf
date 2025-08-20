# Create aws vpc

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "satyam-vpc"
  }
}

# create aws public subnet

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "satyam-public-subnet"
  }
}

# create aws private subnet

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "satyam-private-subnet"
  }
}

# create internet gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "satyam-IGW"
  }
}

# create a public route table

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "satyam-pub-RT"
  }
}

# associate route table

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Create elastic ip address

resource "aws_eip" "lb" {
  domain   = "vpc"

  tags = {
    Name= "satyam-EIP"
  }
}

# Create NAT gateway

resource "aws_nat_gateway" "example" {
  subnet_id     = aws_subnet.public.id
  allocation_id = aws_eip.lb.id

  tags = {
    Name = "satyam-NAT-GW"
  }
}

# create a private route table

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.example.id
  }

  tags = {
    Name = "satyam-pvt-RT"
  }
}

# associate route table

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

# create instance in public subnet

resource "aws_instance" "public_instance" {
  ami           = "ami-020cba7c55df1f615"              # Replace with ur region ami id
  instance_type = "t3.small"
  key_name = "satyam-pair-2"
  subnet_id = aws_subnet.public.id
  associate_public_ip_address = true
  

  tags = {
    Name = "satyam-server-1"
  }
}

resource "aws_instance" "private_instance" {
  ami           = "ami-0a7d80731ae1b2435"          # Replace with ur region ami id
  instance_type = "t3.small"
  key_name = "satyam-pair-2"
  subnet_id = aws_subnet.private.id
  associate_public_ip_address = false
  

  tags = {
    Name = "satyam-server-2"
  }
}