resource "aws_vpc_peering_connection" "management-vpc-to-env-vpc" {
  peer_vpc_id = aws_vpc.main.id
  vpc_id      = lookup(var.management_vpc, "vpc_id", null)
  auto_accept = true
  tags        = local.vpc_peering_tags
}
