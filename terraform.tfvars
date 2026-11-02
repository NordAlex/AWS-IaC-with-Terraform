# REPLACE EVERY VALUE with those assigned by the training platform after Start Task.
aws_region            = "us-east-1"
vpc_name              = "cmtr-sfj054j4-01-vpc"
vpc_cidr              = "10.0.0.0/16"
availability_zones    = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_subnet_names   = ["cmtr-sfj054j4-01-subnet-public-a", "cmtr-sfj054j4-01-subnet-public-b", "cmtr-sfj054j4-01-subnet-public-c"]
public_subnet_cidrs   = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
internet_gateway_name = "cmtr-sfj054j4-01-igw"
routing_table_name    = "cmtr-sfj054j4-01-rt"
