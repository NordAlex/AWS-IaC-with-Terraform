# REPLACE EVERY VALUE with those assigned by the training platform after Start Task.
aws_region            = "us-east-1"
vpc_name              = "cmtr-sfj054j4-vpc"
vpc_cidr              = "10.10.0.0/16"
availability_zones    = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_subnet_names   = ["cmtr-sfj054j4-subnet-public-a", "cmtr-sfj054j4-subnet-public-b", "cmtr-sfj054j4-subnet-public-c"]
public_subnet_cidrs   = ["10.10.1.0/24", "10.10.3.0/24", "10.10.5.0/24"]
internet_gateway_name = "cmtr-sfj054j4-igw"
routing_table_name    = "cmtr-sfj054j4-rt"

allowed_ip_range = ["18.153.146.156/32", "194.44.90.61/32"]

ssh_security_group_name     = "cmtr-sfj054j4-ssh-sg"
public_security_group_name  = "cmtr-sfj054j4-public-http-sg"
private_security_group_name = "cmtr-sfj054j4-private-http-sg"

private_instance_id = "i-014311e4f9956a844"
public_instance_id  = "i-0be038ed12d5219d1"

#app
launch_template_name = "cmtr-sfj054j4-template"
ami_name             = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
iam_instance_name    = "cmtr-sfj054j4-instance_profile"
aws_asg_name         = "cmtr-sfj054j4-asg"
load_balancer_name   = "cmtr-sfj054j4-loadbalancer"