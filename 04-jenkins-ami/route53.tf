data "aws_route53_zone" "selected" {
  name         = "vladbuk.site."
  private_zone = false
}

resource "aws_route53_record" "jenkins-ec2" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "jenkins-ec2.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = 3600
  records = [aws_instance.t2micro_jenkins.public_ip]
}
