resource "aws_security_group" "console" {
  name        = var.name_console
  description = "Default security group."
  vpc_id      = var.vpc_id
  tags = {
    Name = var.name_console
  }
}

resource "aws_security_group_rule" "all-nodes" {
  from_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.console.id
  source_security_group_id =  aws_security_group.console.id
  to_port = 0
  type = "ingress"
}
resource "aws_security_group_rule" "ssh_outside" {
  from_port = 22
  protocol = "tcp"
  security_group_id = aws_security_group.console.id
  cidr_blocks = ["0.0.0.0/0"]
  to_port = 22
  type = "ingress"
}
resource "aws_security_group_rule" "outward" {
  from_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.console.id
  cidr_blocks = ["0.0.0.0/0"]
  to_port = 0
  type = "egress"
}
resource "aws_security_group_rule" "alb-to-appapi" {
  from_port = 9200
  to_port = 9300
  protocol = "tcp"
  security_group_id = aws_security_group.console.id
  source_security_group_id = var.app-api-elb-sg-id
  type = "ingress"
}