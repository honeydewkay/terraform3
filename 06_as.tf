resource "aws_ami_from_instance" "sdkim" {
  name = "${var.name}-ami"
  source_instance_id = aws_instance.sdkim_web.id
  depends_on = [
    aws_instance.sdkim_web
  ]
}

resource "aws_launch_configuration" "sdkim_lacf" {
  name = "${var.name}-lacf"
  image_id = aws_ami_from_instance.sdkim.id
  instance_type = var.ins_type
  iam_instance_profile = "admin_role"
  security_groups = [aws_security_group.sdkim_sg.id]
  key_name = var.key
  user_data =<<-EOF
                #!/bin/bash
                systemctl start httpd
                systemctl enable httpd
                EOF
}

resource "aws_placement_group" "sdkim_pg" {
  name     = "${var.name}-pg"
  strategy = "cluster"

}

resource "aws_autoscaling_group" "sdkim_atsg" {
  name                      = "${var.name}-atsg"
  min_size                  = 2
  max_size                  = 10
  health_check_grace_period = 60
  health_check_type         = "EC2"
  desired_capacity          = 2
  force_delete              = true #false로 바꾸면 사라지지X
  # placement_group           = aws_placement_group.sdkim_pg.id
  launch_configuration      = aws_launch_configuration.sdkim_lacf.name
  vpc_zone_identifier       = [aws_subnet.sdkim_pub[0].id, aws_subnet.sdkim_pub[1].id]
}

resource "aws_autoscaling_attachment" "sdkim_asatt" {
  autoscaling_group_name = aws_autoscaling_group.sdkim_atsg.id
  alb_target_group_arn = aws_lb_target_group.sdkim-albtg.id
}