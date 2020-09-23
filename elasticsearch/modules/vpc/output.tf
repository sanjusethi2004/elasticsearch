#output "private_subnets" {
#  value = "${aws_subnet.private_subnet.*.id}"
#}
output "public_subnets" {
  value =  "${aws_subnet.public_subnet.*.id}"
}

output "public_subnet_id" {
  value = [ "${aws_subnet.public_subnet.*.id}" ]
}

#output "private_subnet_id" {
#  value = [ "${aws_subnet.private_subnet.*.id}" ]
#}

output "vpc_ids" {
  value = "${aws_vpc.elasticsearch_vpc.id}"
}

output "vpc_cdir" {
  value = "${var.vpc_cidr}"
}

#output "private_subnet_count" {
#  value = "${var.private_subnets_count}"
#}

output "public_subnet_count" {
  value = "${var.public_subnets_count}"
}

#output "private_nat_gt" {
#  value = ["${aws_nat_gateway.private_public.*.id}"]
#}

#output "private_route_tables" {
#  value = [ "${aws_route_table.private_route_table.*.id}" ]
#}

output "public_route_tables" {
  value = [ "${aws_route_table.public_rt.*.id}" ]
}

output "availability_zones" {
  value = "${var.aws_availability_zones}"
}



#output "avz" {
#  value = "${data.avz.name}"
#}