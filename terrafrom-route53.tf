provider "aws" {
  access_key = "your_access_key"
  secret_key = "your_secret_key"
 region     = "ap-southeast-1"
}

resource "aws_route53_record" "example" {
  name    = "hosted-zone", 
  zone_id = "your-zone-id"
  type    = "A"
  ttl     = "600"
  records = ["private-ip-of-ec2"]
}

resource "aws_route53_record" "exmaple1" {
  name    = "hosted-zone"
  zone_id = "your-zone-id"
  type    = "A"
  ttl     = "600"
  records = ["private-ip-of-ec2"]
}
