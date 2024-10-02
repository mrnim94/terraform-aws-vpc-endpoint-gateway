data "aws_route_tables" "network" {
  vpc_id = var.vpc_id
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = var.service_name
  route_table_ids   =  length(var.route_table_ids) > 0 ? var.route_table_ids : data.aws_route_tables.network.ids
  vpc_endpoint_type = "Gateway"

  policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "*",
      "Effect": "Allow",
      "Resource": "*",
      "Principal": "*"
    }
  ]
}
POLICY

  tags = {
    Name = "app-vpce-s3"
  }
}