data "aws_route53_zone" "selected" {
    name     = "qasimjibril.com"
    private_zone = false


}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name = "www.${data.aws_route53_zone.selected.name}"
  type = "CNAME"
  ttl = "300"
  records = [ var.dns_name ]
}