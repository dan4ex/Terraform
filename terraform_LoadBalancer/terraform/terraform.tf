terraform {
  required_version = ">= 0.12.0"
}

provider "aws" {
  region = "${var.awsRegion}"
  access_key = "${var.awsAccess_key}"
  secret_key = "${var.awsSecret_key}"
}

provider "google" {
  credentials = "${file("credentials.json")}"
  project = "${var.googleProject}"
  region = "${var.googleRegion}"
}

resource "aws_route53_record" "dns" {
    zone_id = "${data.aws_route53_zone.selected.id}"
    name = "${var.awsRoute53Name[0]}.${data.aws_route53_zone.selected.name}"
    type = "A"
    ttl = "300"
    records = ["${google_compute_forwarding_rule.default.ip_address}"]
}

resource "google_compute_instance" "googleVps" {
    name = "${var.googleVpsName}"
    machine_type = "${var.googleVpsMachineType}"
    zone = "${var.googleVpsZone}"
    boot_disk {
      initialize_params {
        image = "${var.googleVpsImage}"
      }
    }

    metadata = {
      ssh-keys = "${var.sshKey}"
    }

    network_interface {
      network = "${var.googleVpsNetwork}"

      access_config {

      }
    }
}

resource "google_compute_forwarding_rule" "default" {
  name = "${var.loadBalancerName}"
  target = google_compute_target_pool.default.self_link
}

resource "google_compute_target_pool" "default" {
    name = "${var.targetPoolName}"

    instances = [
      "${var.googleVpsZone}/${var.googleVpsName}"
    ]

    health_checks = [
      "${google_compute_http_health_check.default.name}"
    ]
}

resource "google_compute_http_health_check" "default" {
    name = "${var.loadBalancerName}-hc"
    request_path = "/"
}

resource "local_file" "save_inventory" {
  content  = "${data.template_file.inventory.rendered}"
  filename = "${var.pathHosts}"
}

data "aws_route53_zone" "selected" {
  name = "${var.awsRoute53Zone}"
}

data "template_file" "inventory" {
    template = "${file("inventory.tpl")}"

    vars = {
      vps = <<EOT
${google_compute_instance.googleVps.network_interface[0].access_config[0].nat_ip}
EOT
}
}
