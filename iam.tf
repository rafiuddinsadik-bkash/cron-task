resource "aws_iam_role" "iam_role" {
  name = "iam_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com",
        "Service": "ssm.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
      tag-key = "tag-value"
  }
}


resource "aws_iam_instance_profile" "iam_profile" {
  name = "iam_profile"
  role = aws_iam_role.iam_role.name
}


#giving full access to S3 bucket
resource "aws_iam_role_policy" "iam_policy" {
  name = "iam_policy"
  role = aws_iam_role.iam_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}



resource "aws_iam_role_policy_attachment" "iam_attach" {
  role       = aws_iam_role.iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_ssm_activation" "user" {
  name               = "test_ssm_activation"
  description        = "Test"
  iam_role           = aws_iam_role.iam_role.id
  registration_limit = "5"
  depends_on         = [aws_iam_role_policy_attachment.iam_attach]
}