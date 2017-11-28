variable "cidr_block" {}

resource "aws_vpc" "dummy" {
  cidr_block = "${var.cidr_block}"
}

output "vpc" {
  value = "${aws_vpc.dummy.id}"
}

output "vpc_cidr_block" {
  value = "${var.cidr_block}"
}