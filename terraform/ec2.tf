resource "aws_key_pair" "key" {
  key_name   = "${local.common_name}-key"
  public_key = file("/root/.ssh/id_rsa.pub")
}

resource "aws_instance" "public_app" {
  ami                  = local.ami_id
  instance_type        = local.instance_type
  subnet_id            = aws_subnet.public.id
  key_name             = aws_key_pair.key.key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_app.name
  user_data            = file("./userdata")

  vpc_security_group_ids = [
    aws_security_group.app.id
  ]
  associate_public_ip_address = true

  tags = merge(local.common_tags, {
    Name : "${local.common_name}-app-public"
  })
}

resource "aws_instance" "private_app" {
  ami                  = local.ami_id
  instance_type        = local.instance_type
  subnet_id            = aws_subnet.private.id
  key_name             = aws_key_pair.key.key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_app.name
  user_data            = file("./userdata")

  vpc_security_group_ids = [
    aws_security_group.app.id
  ]
  associate_public_ip_address = true

  tags = merge(local.common_tags, {
    Name : "${local.common_name}-app-private"
  })
}
