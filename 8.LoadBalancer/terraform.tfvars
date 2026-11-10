# REPLACE EVERY VALUE with those assigned by the training platform after Start Task.
aws_region = "us-east-1"

terraform = "true"
project   = "cmtr-sfj054j4"

launch_template_name = "cmtr-sfj054j4-template"
ami_name             = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"

key_pair_name     = "cmtr-sfj054j4-keypair"
iam_instance_name = "cmtr-sfj054j4-instance_profile"

ssh_instance_secirity_group_name  = "cmtr-sfj054j4-ec2_sg"
http_instance_secirity_group_name = "cmtr-sfj054j4-http_sg"

aws_asg_name       = "cmtr-sfj054j4-asg"
vpc_id             = "vpc-09a055e237451d3a4"
load_balancer_name = "cmtr-sfj054j4-loadbalancer"