resource "aws_security_group" "all_workr_mgmt" {
  name_prefix = "all_workr_mgmt"
  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group_rule" "all_workr_mgmt_ingress" {
  description = "Allow inbound traffic from eks"
  security_group_id = aws_security_group.all_workr_mgmt.id
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16", ]
}

resource "aws_security_group_rule" "all_workr_mgmt_egress" {
  description = "Allow outbound traffic from anywhere"
  security_group_id = aws_security_group.all_workr_mgmt.id
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ "0.0.0.0/0" ]
}