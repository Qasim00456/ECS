output "target_group_arn" {
    value = aws_lb_target_group.ecs-tg.arn
  
}

output "alb_id" {
  value = [aws_lb_listener.http]
}

output "dns_name" {
  value = aws_lb.ecs-alb.dns_name
}