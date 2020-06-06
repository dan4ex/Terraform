terraform {
  required_version = ">= 0.12.0"
}

provider "vscale" {
  token = "${var.vscale_api_token}"
}

provider "aws" {
  region     = "${var.aws_region}"
  access_key = "${var.my-access-key}"
  secret_key = "${var.my-secret-key}"
}

resource "vscale_ssh_key" "my_ssh_key" {
  key  = "${var.ssh_key}"
  name = "${var.ssh_key_name}"
}

resource "random_string" "password" {
  count   = "${length(var.devs)}"
  length  = "8"
  upper   = true
  lower   = true
  number  = true
  special = false
}

resource "vscale_scalet" "osipov_virt" {
  count     = "${length(var.devs)}"
  name      = "${element(var.devs, count.index)}"
  hostname  = "${element(var.devs, count.index)}"
  rplan     = "${var.rplan}"
  location  = "${var.location}"
  make_from = "${var.make_from}"
  ssh_keys = [
    "${vscale_ssh_key.my_ssh_key.id}"
  ]

  provisioner "remote-exec" {
    inline = [
      "/bin/echo -e \"${element(random_string.password.*.result, count.index)}\n${element(random_string.password.*.result, count.index)}\" | /usr/bin/passwd root"
    ]

    connection {
      type        = "ssh"
      user        = "root"
      host        = self.public_address
      private_key = file("/root/.ssh/id_rsa")
    }
  }
}

resource "aws_route53_record" "www" {
  count   = "${length(var.devs)}"
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = "${element(var.devs, count.index)}.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "300"
  records = ["${vscale_scalet.osipov_virt[count.index].public_address}"]
}

resource "local_file" "passwd" {
    content = "${data.template_file.passwd.rendered}"
    filename = "${var.filename}"
}

data "template_file" "passwd" {
  template = "${file("passwd.tpl")}"
  vars = {
    name = <<EOT
    %{ for name in var.devs ~}
    ${name}
    %{ endfor ~}
EOT
    passwd = <<EOT
    %{ for pass in random_string.password ~}
    ${pass.result}
    %{ endfor ~}
EOT
  }
}

data "aws_route53_zone" "selected" {
  name = "${var.zone}"
}
