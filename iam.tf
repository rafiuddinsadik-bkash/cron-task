resource "aws_iam_role" "crontab_role" {
  name = "crontab-date-ec2-role"

  assume_role_policy = jsonencode(
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
  )
}

#giving full access to S3 bucket
resource "aws_iam_role_policy" "s3_crontab_bucket" {
  name = "s3_bucket_specific_policy"
  role = aws_iam_role.crontab_role.id

  policy = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": [
            "s3:*"
          ],
          "Effect": "Allow",
          "Resource": "arn:aws:s3:::bkash-date-cron-fufh4rw9uhw98-yesbucket"
        }
      ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "test_attach" {
  role       = aws_iam_role.crontab_role.name
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",
    "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
  ])

  policy_arn = each.value
}

resource "aws_iam_instance_profile" "cron_inst_profile" {
  name = "cron-inst-profile"
  role = aws_iam_role.crontab_role.name
}

