# resource "aws_route53_delegation_set" "main" {
#   reference_name = "DynDNS"
# }

# resource "aws_route53_zone" "primary" {
#   name              = "vladbuk.site"
#   delegation_set_id = aws_route53_delegation_set.main.id
# }

# resource "aws_route53_record" "test" {
#   zone_id = aws_route53_zone.primary.zone_id
#   name    = "test.vladbuk.site"
#   type    = "A"
#   ttl     = 3600
#   records = [aws_instance.t2micro_ubuntu_test.public_ip]
# }