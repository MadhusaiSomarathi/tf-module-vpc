output "private_subnets" {
  value = [for i, j in module.private_subnets : j.route_tables.id]
}

output "public_subnets" {
  value = module.public_subnets
}
#
#output "all_route_tables" {
#  value = local.all_route_tables
#
#}

output "test" {
  value = lookup(lookup(module.public_subnets, "public", null), "subnets", null)[0].id
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}

