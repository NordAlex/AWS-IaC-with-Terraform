data "aws_ssm_parameter" "amazon_linux_2023" {
  name = var.ami_name
}

resource "aws_launch_template" "app" {
  name          = var.launch_template_name
  image_id      = data.aws_ssm_parameter.amazon_linux_2023.value
  instance_type = "t3.micro"
  network_interfaces {
    device_index                = 0
    associate_public_ip_address = true
    delete_on_termination       = true

    security_groups = [
      var.ssh_instance_secirity_group_id,
      var.http_instance_secirity_group_id
    ]
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  user_data = filebase64("${path.module}/user_data.sh")
}

resource "aws_autoscaling_group" "app" {
  name             = var.aws_asg_name
  min_size         = 1
  max_size         = 2
  desired_capacity = 2

  vpc_zone_identifier = var.subnet_ids

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  tag {
    key                 = "Terraform"
    value               = "true"
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
    var.lb_http_security_group_id
  ]

  subnets = var.subnet_ids
}

resource "aws_lb_target_group" "app" {
  port        = 80
  protocol    = "HTTP"
  vpc_id = var.vpc_id
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
