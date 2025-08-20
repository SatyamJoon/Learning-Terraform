variable "cidr_block_vpc" {
  description = "cidr-block of vpc"
}
variable "instance_tenancy" {
    description = "instance_tenancy of vpc"
}
variable "Name_vpc" {
    description = "satyam-vpc"
}
variable "cidr_block_public_subnet"{

}
variable "availability_zone_public_subnet"{

}
variable "Name_public_subnet" {
    description = "satyam-public-subnet"
}
variable "cidr_block_private-subnet" {
    description = "private subnet"
}
variable "availability_zone_private_subnet" {
    description = "availabitity"
}
variable "Name_private_subnet" {
    description = "satyam-private-subnet"
}
#create internet gateway
variable "Name_Internet_Gateway" {
    description = "Satyam Internet Gateway Name"
}
# create a public route table
variable "cidr_block_public_route_table" {
    description = "cidr_block_public_route_table"
}
variable "Name__public_route_table" {
    description = "Satyam public route table"
}
# associate route table
# Create elastic ip address
variable "domain" {
    description = "VPC domain"
}
variable "Name_elastic_ip_address" {
    description = "Name of elastic ip address"
}
# Create NAT gateway
variable "Name_NAT_gateway" {
    description = "Name of Nat gateway"
}
# create a private route table
variable "cidr_block_private_route_table" {
    description = "cidr block of private route table"
}
variable "Name_private_route_table" {
    description = "Name of private route table"
}
# associate route table
# create instacne in public subnet
variable "ami_instance_public_subnet" {
    description = "ami of public subnet"
}
variable "instance_type_instance_public_subnet" {
   description = "instance type of public subnet"
}
variable "key_name__instance_public_subnet" {
   description = "key name of public subnet"
}

variable "associate_instance_public_ip_address" {
   description = "associate public ip address of public subnet"
}
variable "Name_instance_public_subnet" {
    description = "Name of instance public subnet"
}
variable "ami_instance_private_subnet" {
    description = "ami of private subnet"
}
variable "instance_type_instance_private_subnet" {
    description = "instance type of private subnet"
}
variable "key_name_instance_private_subnet" {
    description = "key name of private subnet"
}
variable "associate_instance_private_ip_address" {
    description = "associate instance ip address of public subnet"
}
variable "Name_instance_private_subnet" {
    description = "Name of instance private route table"
}