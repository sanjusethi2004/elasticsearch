resource "aws_instance" "ec2_create" {
  instance_type = var.instance_type
  ami           = var.ami_id
  count         = var.node_count
  monitoring        = var.ec2_monitoring
  source_dest_check = var.source_dest_check
  #key_name = "${aws_key_pair.wp_auth.id
  key_name             = var.key_name
  iam_instance_profile = var.iam_role_name

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.volume_type
  }

  subnet_id                   = var.private_subnets[count.index]
  associate_public_ip_address = var.associate_public_ip_address
  availability_zone           = var.aws_availability_zones[count.index]
  vpc_security_group_ids      = var.secuity_group_id

  tags = {
    Owner           = var.owner
    Name            = format("${var.node_name}-%s",count.index)
    ansibleFilter   = var.AnsibleFilter
    ansibleNodeType = var.node_name
    ansibleNodeName = format("${var.node_name}-%s",count.index)
    }

  volume_tags = {
    Owner           = var.owner
    Name            = format("${var.node_name}-%s",count.index)
    ansibleFilter   = var.AnsibleFilter
    ansibleNodeType = var.node_name
    ansibleNodeName = format("${var.node_name}-%s",count.index)
  }

  #user_data = data.template_file.my_setup.rendered
}

