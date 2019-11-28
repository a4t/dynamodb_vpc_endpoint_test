locals {
  common_name = "${local.common_tags.Service}-${local.common_tags.Env}"
  common_tags = {
    Service = "dynamodb-vpc-endpoint-test"
    Env     = var.env
  }
  ami_id        = "ami-068a6cefc24c301d2"
  instance_type = "t3.nano"
}
