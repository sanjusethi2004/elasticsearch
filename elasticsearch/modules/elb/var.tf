variable "elb_name" {}
variable "subnets" {
  type = list(string)
}
variable "security_grp_id" {
  type = list(string)
}
variable "elb_healthy_threshold" {
  default = "2"
}
variable "kube_scheduler_port" {
  default = "8080"
}
variable "elb_unhealthy_threshold" {
  default = "2"
}
variable "elb_timeout" {
  default = "15"
}
variable "elb_interval" {
  default = "30"
}
variable "cross_zone_load_balancing" {
  default = true
}
variable "instance_protocol" {
  default = "tcp"
 }
variable "instance_port" {
  default = "6443"
 }
variable "lb_type" {
  default = "network"
 }
variable "lb_port" {
  default = "443"
 }
variable "lb_protocol" {
  default = "tcp"
 }
variable "target" {}
variable "idle_timeout" {
  default = "400"
}
variable "connection_draining" {
  default = true
}
variable "connection_draining_timeout" {
  default = "400"
}
variable "instances_id" {
  type = list(string)
}

