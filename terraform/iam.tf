resource "aws_iam_role" "ec2_app" {
  name = "${local.common_name}-ec2-app"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}

EOF
}

resource "aws_iam_instance_profile" "ec2_app" {
  name = "${local.common_name}-ec2-app"
  path = "/"
  role = aws_iam_role.ec2_app.name
}

resource "aws_iam_role_policy" "ec2_app_dynamodb" {
  name = "dynamodb"
  role = aws_iam_role.ec2_app.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:GetItem"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
