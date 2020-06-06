provider "digitalocean" {
  token = "${var.token_digitalocean}"
}

provider "aws" {
  region     = "${var.provider_region}"
  access_key = "${var.my-access-key}"
  secret_key = "${var.my-secret-key}"
}

resource "digitalocean_droplet" "droplet_Osipov" {
  image  = "${var.vps_image}"
  name   = "${var.vps_name}"
  region = "${var.vps_region}"
  size   = "${var.vps_resources}"
  ssh_keys = [
    "${digitalocean_ssh_key.my_key.id}"
  ]
}

resource "digitalocean_ssh_key" "my_key" {
  name       = "${var.ssh_key_name}"
  public_key = "${var.ssh_key}"
}

resource "aws_route53_record" "www" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = "${var.dns_name}.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "300"
  records = ["${digitalocean_droplet.droplet_Osipov.ipv4_address}"]
}

data "aws_route53_zone" "selected" {
  name = "${var.dns_zone}"
}
