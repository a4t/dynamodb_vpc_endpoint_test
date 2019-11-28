resource "aws_vpc" "main" {
  cidr_block = "192.168.${var.vpc_cidr_number}.0/24"

  tags = merge(local.common_tags, {
    Name : local.common_name
  })
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.${var.vpc_cidr_number}.0/28"
  availability_zone = var.availability_zone

  tags = merge(local.common_tags, {
    Name : "${local.common_name}-${var.availability_zone}"
  })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name : "${local.common_name}-igw"
  })
}

resource "aws_route_table" "r" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "${chomp(data.http.myip.body)}/32"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.common_tags, {
    Name : "${local.common_name}-public"
  })
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.r.id
}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.ap-northeast-1.dynamodb"

  tags = merge(local.common_tags, {
    Name : "${local.common_name}-dynamodb-gateway"
  })
}

resource "aws_vpc_endpoint_route_table_association" "dynamodb" {
  route_table_id  = aws_route_table.r.id
  vpc_endpoint_id = aws_vpc_endpoint.dynamodb.id
}
