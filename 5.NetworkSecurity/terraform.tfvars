# REPLACE EVERY VALUE with those assigned by the training platform after Start Task.
aws_region = "us-east-1"

project_tag = "cmtr-sfj054j4"

allowed_ip_range = ["18.153.146.156/32", "192.168.0.104/32"]

ssh_security_group_name     = "cmtr-sfj054j4-ssh-sg"
public_security_group_name  = "cmtr-sfj054j4-public-http-sg"
private_security_group_name = "cmtr-sfj054j4-private-http-sg"

private_instance_id = "i-0be038ed12d5219d1"
public_instance_id  = "i-014311e4f9956a844"

vpc_name = "cmtr-sfj054j4-vpc"
vpc_name_filter = "tag:Name"
