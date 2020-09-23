provider "aws" {
  #version = "1.31.0"
  region  = var.aws_region
  profile = var.aws_profile
}


data "aws_ami" "ubuntu" {
  most_recent = true
  owners = [var.ubuntu_account_number]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

#Network
module "my_vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr

  #tenancy =  "${var.tenancy}"
  disable_nat_gt         = var.disable_nat_gt
  public_subnets         = var.public_subnets
  public_subnets_count   = 3
  aws_availability_zones = var.aws_availability_zones
}

module "myelb" {
  source           = "./modules/elb"
  subnets          = module.my_vpc.public_subnets
  instances_id     = module.my_ec2_elasticssearch.ec2s
  security_grp_id  = [module.my_sgp.app_api_sgp_id]
  instance_port    = 9200
  target           = "http:9200/_cluster/health?pretty"
  elb_name         =  "elasticssearch"
}

module "my_sgp" {
  source                = "./modules/security_group"
  vpc_id                = module.my_vpc.vpc_ids
  name_console          = "console"
  vpc_cidr              = module.my_vpc.vpc_cdir
  name_app_api          = "elasticsearch"
  app-api-elb-sg-id     = module.my_sgp.app_api_sgp_id
}

module "my_iam" {
  source           = "./modules/iam"
  iam_profile_name = "var.iam_profile_name"
  iam_name         = "var.iam_name"
}

module "my_ec2_elasticssearch" {
  source                 = "./modules/ec2"
  instance_type          = var.node_type[0]
  private_subnets        = module.my_vpc.public_subnets
  ami_id                 = data.aws_ami.ubuntu.id
  node_count             = var.elasticssearch_count
  node_name              = var.node_name[0]
  key_name               = var.key_name
  iam_role_name          = module.my_iam.iam_name
  root_volume_size       = var.root_volume_size
  aws_availability_zones = var.aws_availability_zones
  secuity_group_id       = [module.my_sgp.console_sgp_id]
  source_dest_check      = true
}

resource "null_resource" "elasticsearch_ansible" {

  provisioner "local-exec" {
    command = "aws ec2 wait instance-status-ok --instance-ids ${module.my_ec2_elasticssearch.ec2s1} --profile ${var.aws_profile}  --region ${var.aws_region} && cd ansible && sudo ansible-playbook main.yml"
  }

}