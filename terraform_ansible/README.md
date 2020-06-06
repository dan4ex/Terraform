# Terraform with provisioner ansible
---
### Description

Terraform creates 2 VPS, ansible configures one VPS as nginx-proxy, the second as nginx server

### Launch project

To start, enter the tokens in the **terraform.tfvars** file, enter the your ssh public key in variables **sshPubKey**, go to the terraform folder and execute:

    $ cd terraform/
    $ sudo terraform apply
    
### Author

* [Daniil Osipov](https://career.habr.com/dmatusenko) - *DevOps SurfStudio*
