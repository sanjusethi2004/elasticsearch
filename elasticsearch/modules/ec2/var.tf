variable "instance_type" {}
variable "node_name" {}
variable "ami_id" {}
variable "node_count" {}
variable "iam_role_name" {}

variable "secuity_group_id" {
  type = list(string)
  default = []
}
variable "private_subnets" {
  type = list(string)
}
variable "ec2_monitoring" {
  default = "true"
}
variable "source_dest_check" {
  default = true
}
variable "AnsibleFilter" {
  default = "elasticsearch"
}
variable "owner" {
  default = "Myself"
}
variable "key_name" {}
variable "root_volume_size" {
  default = "15"
}
variable "volume_type" {
  default = "gp2"
}
variable "associate_public_ip_address" {
  default = "true"
}
variable "aws_availability_zones" {
  type = list(string)
}