output "lb_dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.my_flask_app_lb.dns_name
}

output "aws_route53_record" {
  description = "DNS name of the load balancer"
  value       = aws_route53_record.flask_app_dns.name
}