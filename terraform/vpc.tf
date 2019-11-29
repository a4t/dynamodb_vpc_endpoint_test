resource "aws_vpc" "main" {
  cidr_block = "192.168.${var.vpc_cidr_number}.0/24"

  tags = merge(local.common_tags, {
    Name : local.common_name
  })
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.${var.vpc_cidr_number}.0/28"
  availability_zone = var.availability_zone

  tags = merge(local.common_tags, {
    Name : "${local.common_name}-public-${var.availability_zone}"
  })
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.${var.vpc_cidr_number}.16/28"
  availability_zone = var.availability_zone

  tags = merge(local.common_tags, {
    Name : "${local.common_name}-private-${var.availability_zone}"
  })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name : "${local.common_name}-igw"
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.common_tags, {
    Name : "${local.common_name}-public"
  })
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.common_tags, {
    Name : "${local.common_name}-private"
  })
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.ap-northeast-1.dynamodb"

  tags = merge(local.common_tags, {
    Name : "${local.common_name}-dynamodb-gateway"
  })
}

resource "aws_vpc_endpoint_route_table_association" "dynamodb" {
  route_table_id  = aws_route_table.private.id
  vpc_endpoint_id = aws_vpc_endpoint.dynamodb.id
}
