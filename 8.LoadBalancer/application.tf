data "aws_ssm_parameter" "amazon_linux_2023" {
  name = var.ami_name
}

data "aws_key_pair" "key_pair" {
  key_name = var.key_pair_name
}

data "aws_iam_instance_profile" "iam_instance" {
  name = var.iam_instance_name
}

data "aws_security_group" "ssh_inbound_id" {
  name = var.ssh_instance_secirity_group_name
}

data "aws_security_group" "http_inbound_id" {

  name = var.http_instance_secirity_group_name
}

data "aws_subnet" "public_a" {
  vpc_id     = var.vpc_id
  cidr_block = "10.0.1.0/24"
}

data "aws_subnet" "public_b" {
  vpc_id     = var.vpc_id
  cidr_block = "10.0.3.0/24"
}

resource "aws_launch_template" "app" {
  name          = var.launch_template_name
  image_id      = data.aws_ssm_parameter.amazon_linux_2023.value
  instance_type = "t3.micro"
  key_name      = data.aws_key_pair.key_pair.key_name
  iam_instance_profile {
    name = data.aws_iam_instance_profile.iam_instance.name
  }

  network_interfaces {
    device_index          = 0
    delete_on_termination = true

    security_groups = [
      data.aws_security_group.http_inbound_id.id,
      data.aws_security_group.ssh_inbound_id.id,
    ]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Terraform = var.terraform
      Project   = var.project
    }
  }

  tag_specifications {
    resource_type = "volume"

    tags = {
      Terraform = var.terraform
      Project   = var.project
    }
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  user_data = filebase64("${path.module}/user_data.sh")

  tags = {
    Terraform = var.terraform
    Project   = var.project
  }
}

resource "aws_autoscaling_group" "app" {
  name             = var.aws_asg_name
  min_size         = 1
  max_size         = 2
  desired_capacity = 2

  vpc_zone_identifier = [data.aws_subnet.public_a.id, data.aws_subnet.public_b.id]

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  tag {
    key                 = "Terraform"
    value               = "true"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = var.project
    propagate_at_launch = true
  }

  lifecycle {
    ignore_changes = [
      load_balancers,
      target_group_arns
    ]
  }
}

resource "aws_lb" "app" {
  name               = var.load_balancer_name
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    data.aws_security_group.http_inbound_id.id
  ]

  subnets = [data.aws_subnet.public_a.id, data.aws_subnet.public_b.id]
}

resource "aws_lb_target_group" "app" {
  name        = "${var.project}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    enabled             = true
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}

resource "aws_autoscaling_attachment" "app" {
  autoscaling_group_name = aws_autoscaling_group.app.name
  lb_target_group_arn    = aws_lb_target_group.app.arn
}
