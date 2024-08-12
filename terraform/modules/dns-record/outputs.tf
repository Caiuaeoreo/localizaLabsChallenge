output "aws_route53_record" {
  description = "DNS name of the load balancer"
  value       = aws_route53_record.flask_app_dns.fqdn
}