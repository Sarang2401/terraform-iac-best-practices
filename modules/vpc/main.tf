resource "aws_vpc" "this" {
  cidr_block = var.cidr

  tags = {
    Name = "vpc-${var.env}"
  }
}
