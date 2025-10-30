resource "aws_vpc" "main" {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "cmtr-zt9dp1hp-01-vpc"
  }
}

resource "aws_subnet" "publicA" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.10.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true # <-- AÑADIDO: Para hacerla pública
  tags = {
    Name = "cmtr-zt9dp1hp-01-subnet-public-a"
  }
}

resource "aws_subnet" "publicB" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.10.3.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true # <-- AÑADIDO: Para hacerla pública
  tags = {
    Name = "cmtr-zt9dp1hp-01-subnet-public-b"
  }
}

resource "aws_subnet" "publicC" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.10.5.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true # <-- AÑADIDO: Para hacerla pública
  tags = {
    Name = "cmtr-zt9dp1hp-01-subnet-public-c"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "cmtr-zt9dp1hp-01-igw"
  }
}

resource "aws_route_table" "routing" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "cmtr-zt9dp1hp-01-rt"
  }
}

resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.routing.id
  destination_cidr_block = "0.0.0.0/0" # "0.0.0.0/0" significa "todo el tráfico"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_route_table_association" "associateA" {
  subnet_id      = aws_subnet.publicA.id
  route_table_id = aws_route_table.routing.id
}

resource "aws_route_table_association" "associateB" {
  subnet_id      = aws_subnet.publicB.id
  route_table_id = aws_route_table.routing.id
}

resource "aws_route_table_association" "associateC" {
  subnet_id      = aws_subnet.publicC.id
  route_table_id = aws_route_table.routing.id
}
