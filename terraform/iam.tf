resource "aws_iam_instance_profile" "ec2_app" {
  name = "${local.common_name}-ec2-app"
  role = aws_iam_role.role.name
}

resource "aws_iam_role" "role" {
  name = "${local.common_name}-ec2-app"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}
