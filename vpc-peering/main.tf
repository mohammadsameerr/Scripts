resource "aws_vpc" "sam-vpc10" {
  cidr_block = "10.1.0.0/16"
}

resource "aws_vpc" "sam-vpc20" {
  cidr_block = "10.2.0.0/16"
}

resource "aws_vpc_peering_connection" "sam-vpc10" {
  peer_vpc_id   = aws_vpc.sam-vpc20.id
  vpc_id        = aws_vpc.sam-vpc10.id
  auto_accept   = true

  tags = {
    Name = "VPC Peering between foo and bar"
  }
}

