variable "aws_region" {
  default = "us-west-2"
}

variable "aws_profile" {
  default = "spusdev"
}

variable "vpc_cidr" {
  default = "10.0.2.0/24"
}

variable "aws_availability_zones" {
  default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "destination_cidr_block" {
  default = "0.0.0.0/0"
}

variable "cidr_block" {
  default = "0.0.0.0/0"
}

variable "public_subnets" {
  default = ["10.0.2.0/27", "10.0.2.32/27", "10.0.2.64/27"]
}

#variable "private_subnets" {
#  default = ["10.0.2.96/27", "10.0.2.128/27", "10.0.2.160/27"]
#}

#variable "rds_subnet" {
#  default = ["10.0.2.192/27", "10.0.2.224/27"]
#}

variable "disable_nat_gt" {
  default = "1"
}

variable "root_volume_size" {
  default = "15"
}

variable "key_name" {
  default = "elasticsearch"
}

variable "node_name" {
  default = ["elasticssearch"]
}

variable "node_type" {
  default = ["m5.large"]
}

variable "elasticssearch_count" {
  default = "3"
}

variable "iam_name" {
  default = "elasticsearch-cluster"
}

variable "iam_profile_name" {
  default = "test-profile"
}

variable "sgp_name" {
  default = "console"
}

variable "source_dest_check" {
  default = false
}

variable "ubuntu_account_number" {
  default = "099720109477"
}
