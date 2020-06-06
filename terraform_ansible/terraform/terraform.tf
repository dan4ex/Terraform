terraform {
  required_version = ">= 0.12.0"
}

provider "digitalocean" {
  token = "${var.tokenDigitalocean}"
}

provider "aws" {
  region = "${var.awsRegion}"
  access_key = "${var.awsAccess_key}"
  secret_key = "${var.awsSecret_key}"
}

resource "aws_route53_record" "dns" {
    count   = "${length(var.awsRoute53Name)}"
    zone_id = "${data.aws_route53_zone.selected.id}"
    name = "${var.awsRoute53Name[count.index]}.${data.aws_route53_zone.selected.name}"
    type = "A"
    ttl = "300"
    records = ["${digitalocean_droplet.droplet_Osipov[count.index].ipv4_address}"]
}

resource "digitalocean_droplet" "droplet_Osipov" {
  count   = "${length(var.awsRoute53Name)}"
  image  = "${var.vpsImage}"
  name   = "${var.awsRoute53Name[count.index]}"
  region = "${var.vpsRegion}"
  size   = "${var.vpsSize}"
  ssh_keys = [
    "${digitalocean_ssh_key.osipov_key.id}"
  ]

  provisioner "remote-exec" {
     inline = [
       "sudo apt update && sudo apt-get install -y python"
       ]

    connection {
      type     = "ssh"
      user     = "root"
      host     = self.ipv4_address
      private_key = file("/root/.ssh/id_rsa")
    }
  }
}

resource "digitalocean_ssh_key" "osipov_key" {
  name       = "${var.sshName}"
  public_key = "${var.sshPubKey}"
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
%{ for vps in digitalocean_droplet.droplet_Osipov ~}
[${vps.name}]
${vps.ipv4_address}

%{ endfor ~}
EOT
}
}

resource "null_resource" "droplet_Osipov" {
  provisioner "local-exec" {
    command = "sudo ansible-playbook -i inventory/hosts site.yml"
  }
  depends_on = [digitalocean_droplet.droplet_Osipov]
}
