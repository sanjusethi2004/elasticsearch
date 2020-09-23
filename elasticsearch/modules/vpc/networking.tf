####################VPC###################
resource "aws_vpc" "elasticsearch_vpc" {
  cidr_block       = var.vpc_cidr
  #instance_tenancy = var.tenancy
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "elasticsearch_vpc"
  }
}
################Public Subnet Object####################################
resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.elasticsearch_vpc.id
  cidr_block              = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone       = var.aws_availability_zones[count.index]
  #availability_zone       = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "public"
  }
}
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.elasticsearch_vpc.id
  tags = {
    Name = "igw"
  }
}
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.elasticsearch_vpc.id
  tags = {
    Name = "public_rt"
  }
}
resource "aws_route" "public_route" {
    route_table_id = aws_route_table.public_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
}

resource "aws_route_table_association" "public_assoc" {
  count = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

#################Private subnet Object############################
#resource "aws_subnet" "private_subnet" {
#  vpc_id                  = "${aws_vpc.elasticsearch_vpc.id}"
#  cidr_block              = "${var.private_subnets[count.index]}"
#  map_public_ip_on_launch = true
#  availability_zone       = "${var.aws_availability_zones[count.index]}"
#  #availability_zone       = "${data.aws_availability_zones.available.names[1]}"
#  count                   = "${length(var.private_subnets)}"
#  tags {
#    Name = "private"
#  }
#}
# Allocate Elastic IPs for NAT Gateway
#resource "aws_eip" "public_eip" {
#  vpc      = true
#  count = "${var.disable_nat_gt ? "${length(var.private_subnets)}" : 0}"
#  depends_on = ["aws_internet_gateway.internet_gateway"]
#}

# Assign NAT Gateway to Public Subnet and Elastic IPs
#resource "aws_nat_gateway" "private_public" {
#  count = "${var.disable_nat_gt ? "${length(var.private_subnets)}" : 0}"
#  allocation_id = "${element(aws_eip.public_eip.*.id, count.index)}"
#  subnet_id     = "${element(aws_subnet.public_subnet.*.id, count.index)}"
#  depends_on = ["aws_internet_gateway.internet_gateway"]
#  tags = {
#    Name = "private_public"
#  }
#}

# Create Private Subnet Route Tables
#resource "aws_route_table" "private_route_table" {
#    vpc_id = "${aws_vpc.elasticsearch_vpc.id}"
#    count = "${length(var.private_subnets)}"
#  tags {
#        Name = "private_route_table"
#    }
#}
# Create Nat Routes
#resource "aws_route" "private_nat_gt" {
#  count = "${var.disable_nat_gt ? "${length(var.private_subnets)}" : 0}"
#  route_table_id = "${element(aws_route_table.private_route_table.*.id, count.index)}"
#  destination_cidr_block = "0.0.0.0/0"
#  nat_gateway_id = "${element(aws_nat_gateway.private_public.*.id, count.index)}"
#}

#resource "aws_route_table_association" "private_assoc" {
#  count = "${length(var.private_subnets)}"
#  subnet_id      = "${element(aws_subnet.private_subnet.*.id, count.index)}"
#  route_table_id = "${element(aws_route_table.private_route_table.*.id, count.index)}"
#}

