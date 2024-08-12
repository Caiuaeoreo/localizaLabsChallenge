data "aws_route53_zone" "main" {
  name = "${var.account_id}.realhandsonlabs.net."
}

data "aws_elb" "my_flask_app_lb" {
  name = var.load_balancer_name
}

resource "aws_route53_record" "flask_app_dns" {
  zone_id = data.aws_route53_zone.main.id
  name    = "challenge-localiza-labs.${data.aws_route53_zone.main.name}"
  type    = "A"

  alias {
    name                   = data.aws_elb.my_flask_app_lb.dns_name
    zone_id                = var.hosted_zone_id
    evaluate_target_health = true
  }
}