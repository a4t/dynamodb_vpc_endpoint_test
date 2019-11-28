resource "aws_key_pair" "key" {
  key_name   = "${local.common_name}-key"
  public_key = file("/root/.ssh/id_rsa.pub")
}

resource "aws_instance" "web" {
  ami                  = local.ami_id
  instance_type        = local.instance_type
  subnet_id            = aws_subnet.main.id
  key_name             = aws_key_pair.key.key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_app.name

  vpc_security_group_ids = [
    aws_security_group.app.id
  ]
  associate_public_ip_address = true

  tags = merge(local.common_tags, {
    Name : "${local.common_name}-app"
  })
}
