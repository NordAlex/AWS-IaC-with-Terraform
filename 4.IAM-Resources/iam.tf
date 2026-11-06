data "aws_s3_bucket" "existing" {
  bucket = "cmtr-sfj054j4-bucket-1793948310"
}

resource "aws_iam_group" "group" {
  name = var.iam_group_name

}

resource "aws_iam_group_policy_attachment" "group_policy" {
  group      = aws_iam_group.group.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_policy" "policy" {
  name = var.iam_policy_name

  policy = templatefile("${path.module}/policy.json", {
    bucket_name = data.aws_s3_bucket.existing.id
  })


  tags = {
    Name    = var.iam_policy_name
    Project = var.project_tag
  }
}

resource "aws_iam_role" "role" {
  name = var.iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name    = var.iam_role_name
    Project = var.project_tag
  }
}
resource "aws_iam_instance_profile" "instance" {
  role = aws_iam_role.role.name

  tags = {
    Name    = var.iam_role_name
    Project = var.project_tag
  }
}