
data "aws_route53_zone" "coniliuscf.org" {
  name = "coniliuscf.org"
}
#data.aws_route53_zone.coniliuscf.zone_id
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.coniliuscf.zone_id
  name    = "www.coniliuscf.org"
  type    = "A"

  alias {
    name                   = aws_lb.kojitechs-lb.dns_name
    zone_id                = aws_lb.kojitechs-lb.dns_id
    evaluate_target_health = true
  }
}

module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "3.0.0"

  domain_name               = trimsuffix(data.aws_route53_zone.coniliuscf.name, ".")
  zone_id                   = data.aws_route53_zone.coniliuscf.zone_id
  subject_alternative_names = ["*.coniliuscf.org"]
}

output "dns-name"{
  value= ("https://%s",aws_route53_record.www.domain)
  description = "click on this link to connect to our application"
}
