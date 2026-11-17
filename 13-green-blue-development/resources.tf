
locals {
  common_tags = {
    Project   = var.name_prefix
    ManagedBy = "Terraform"
  }
}

# Application Load Balancer

resource "aws_lb" "main" {
  name               = "${var.name_prefix}-lb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    data.aws_security_group.lb.id
  ]

  subnets = [
    data.aws_subnet.public1.id,
    data.aws_subnet.public2.id
  ]

  tags = local.common_tags
}

# Target Groups

resource "aws_lb_target_group" "blue" {
  name     = "${var.name_prefix}-blue-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.existing.id

  health_check {
    path    = "/"
    matcher = "200"
  }

  tags = local.common_tags
}

resource "aws_lb_target_group" "green" {
  name     = "${var.name_prefix}-green-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.existing.id

  health_check {
    path    = "/"
    matcher = "200"
  }

  tags = local.common_tags
}

# Launch Templates

resource "aws_launch_template" "blue" {
  name          = "${var.name_prefix}-blue-template"
  image_id      = data.aws_ssm_parameter.ami.value
  instance_type = var.instance_type

  vpc_security_group_ids = [
    data.aws_security_group.ssh.id,
    data.aws_security_group.http.id
  ]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    dnf install -y httpd
    echo "<h1>Blue Environment</h1>" > /var/www/html/index.html
    systemctl enable --now httpd
  EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = merge(local.common_tags, {
      Name = "${var.name_prefix}-blue-instance"
    })
  }

  tags = local.common_tags
}

resource "aws_launch_template" "green" {
  name          = "${var.name_prefix}-green-template"
  image_id      = data.aws_ssm_parameter.ami.value
  instance_type = var.instance_type

  vpc_security_group_ids = [
    data.aws_security_group.ssh.id,
    data.aws_security_group.http.id
  ]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    dnf install -y httpd
    echo "<h1>Green Environment</h1>" > /var/www/html/index.html
    systemctl enable --now httpd
  EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = merge(local.common_tags, {
      Name = "${var.name_prefix}-green-instance"
    })
  }

  tags = local.common_tags
}

# Auto Scaling Groups

resource "aws_autoscaling_group" "blue" {
  name             = "${var.name_prefix}-blue-asg"
  min_size         = 1
  max_size         = 2
  desired_capacity = 1

  vpc_zone_identifier = [
    data.aws_subnet.public1.id,
    data.aws_subnet.public2.id
  ]

  target_group_arns = [
    aws_lb_target_group.blue.arn
  ]

  health_check_type = "ELB"

  launch_template {
    id      = aws_launch_template.blue.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.name_prefix}-blue-instance"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = var.name_prefix
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "green" {
  name             = "${var.name_prefix}-green-asg"
  min_size         = 1
  max_size         = 2
  desired_capacity = 1

  vpc_zone_identifier = [
    data.aws_subnet.public1.id,
    data.aws_subnet.public2.id
  ]

  target_group_arns = [
    aws_lb_target_group.green.arn
  ]

  health_check_type = "ELB"

  launch_template {
    id      = aws_launch_template.green.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.name_prefix}-green-instance"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = var.name_prefix
    propagate_at_launch = true
  }
}

# Weighted HTTP Listener

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"

    forward {
      target_group {
        arn    = aws_lb_target_group.blue.arn
        weight = var.blue_weight
      }

      target_group {
        arn    = aws_lb_target_group.green.arn
        weight = var.green_weight
      }
    }
  }

  tags = local.common_tags
}
