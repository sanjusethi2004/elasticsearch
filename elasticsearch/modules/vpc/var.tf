variable "vpc_cidr" {}

#variable "tenancy" {}

variable "aws_availability_zones" {
  type = list(string)
  default = []
}

#data "avz" "name" {}

variable "public_subnets" {
  type = list(string)
  default = []

}
variable "private_subnets" {
  type = list(string)
  default = []
}

variable "disable_nat_gt" {
  default= "1"
}

#variable "private_subnets_count" {
#  default = "3"
#}

variable "public_subnets_count" {
  default = "3"
}

