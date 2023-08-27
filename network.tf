resource "aws_vpc" "qtvpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = local.Name
  }
}
resource "aws_subnet" "subnets" {
  count             = length(var.subnet_names)
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone = var.subnet_az[count.index]
  vpc_id            = aws_vpc.qtvpc.id
  tags = {
    Name = var.subnet_names[count.index]
  }
  depends_on = [aws_vpc.qtvpc]
}
data "aws_route_table" "default" {
  vpc_id     = aws_vpc.qtvpc.id
  depends_on = [aws_vpc.qtvpc]

}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.qtvpc.id
  tags = {
    Name = "qtvpcigw"
  }
  depends_on = [aws_vpc.qtvpc]

}
resource "aws_route" "igwroute" {
  route_table_id         = data.aws_route_table.default.id
  destination_cidr_block = local.open
  gateway_id             = aws_internet_gateway.gw.id
  depends_on = [
    aws_vpc.qtvpc,
    aws_internet_gateway.gw
  ]

}

