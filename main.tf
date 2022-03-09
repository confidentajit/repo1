provider "aws" {
  region = var.region
}
resource "aws_launch_configuration" "mylunch" {
  name            = "web config"
  image_id        = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [var.security_grpup_id]  
}

resource "aws_autoscaling_group" "myautoscalling" {
  name                       = "myauto"
  max_size                   = 2
  min_size                   = 1
  desired_capacity           = 1
  health_check_grace_period  = 60
  health_check_type          = "EC2"
  force_delete               = true
  launch_configuration       = aws_launch_configuration.mylunch.name
  availability_zones         = ["us-east-1d"]
}
resource "aws_autoscaling_policy" "asp" {
  name                   = "asp_policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 50
  policy_type            = "SimpleScaling"
  autoscaling_group_name = aws_autoscaling_group.myautoscalling.name
}
resource "aws_cloudwatch_metric_alarm" "aws_cloudwatch_metric_alarm" {
  alarm_name = "terraform test cloudwatch"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "30"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  
   dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.myautoscalling.name
  }
  
    actions_enabled     = true
    alarm_actions     = [aws_autoscaling_policy.asp.arn]

}
  
