module "acp" {
  source = "./dummy"
  providers = {
    aws = "aws.CI"
  }
  cidr_block = "10.0.0.0/16"
}

module "acpagain" {
  source = "./dummy"
  providers = {
    aws = "aws.CI"
  }
  cidr_block = "10.2.0.0/16"
}


data "aws_vpc_peering_connection" "pc" {
  vpc_id = "${module.acp.vpc}"
  peer_cidr_block = "${module.acp.vpc_cidr_block}"
}

# Create a route table
resource "aws_route_table" "rt" {
  vpc_id = "${module.acp.vpc}"
}

//# Create a route
resource "aws_route" "r" {
  route_table_id            = "${aws_route_table.rt.id}"
  destination_cidr_block    = "${data.aws_vpc_peering_connection.pc.peer_cidr_block}"
  vpc_peering_connection_id = "${data.aws_vpc_peering_connection.pc.id}"
}