# Create LoadBalancer GCP with terraform
---
### Short info

Creating LoadBalancer and VPS, creating corresponding DNS records in aws route53.

### Before the beginning
To up infrastructure, enter the aws tokens in the **terraform.tfvars** file, enter the your ssh public key in variables **sshPubKey**, create file **credentials.json with youe google credentials, go to the terraform folder and execute:
    
    $ cd terraform/
    $ sudo terraform apply

# Ansible provisioning

To start, just execute:

    $ sudo ansible-playbook site.yml

**The web interface is available at http://dan4exlb.devops.rebrain.srwx.net/**

### Author

* [Daniil Osipov](https://career.habr.com/dmatusenko) - *DevOps SurfStudio*


