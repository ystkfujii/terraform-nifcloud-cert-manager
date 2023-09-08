# terraform-nifcloud-cert-manager

Terraform module for managing certificates on NIFCLOUD.
Specifically, acme provider is used to create or renew certificates and upload them to NIFCLOUD.

## Usage

There are examples included in the examples folder but simple usage is as follows:

```hcl
locals {
  nifcloud_access_key = "YOUR_ACCESS_KEY"
  nifcloud_secret_key = "YOUR_SECRET_KEY"

  acme_email_address = "XXXXXX@YYYY.com"
  # see: https://letsencrypt.org/docs/acme-protocol-updates/#acme-v2-rfc-8555
  server_url         = "https://acme-staging-v02.api.letsencrypt.org/directory"

  certificates = {
    "hoge" = {
      common_name               = "hoge.com"
      subject_alternative_names = ["hoge.com", "*.hoge.com"]
    }
    "geho" = {
      common_name               = "geho.com"
      subject_alternative_names = ["geho.com", "*.geho.com"]
    }
  }
}

provider "nifcloud" {
  region = "jp-east-1"
}

provider "acme" {
  server_url = local.server_url
}

module "cert" {
  source = "./../../"

  acme_email_address = local.acme_email_address

  certificates        = local.certificates
  nifcloud_access_key = local.nifcloud_access_key
  nifcloud_secret_key = local.nifcloud_secret_key
}
```

Then perform the following commands on the root folder:

- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform apply -destroy` to destroy the built infrastructure

## Requirements

Before this module can be used on a project, you must ensure that the following pre-requisites are fulfilled:

1. Terraform are [installed](#software-dependencies) on the machine where Terraform is executed.
2. The NIFCLOUD Account you execute the module with has the right permissions.
    - You can set environment variable `NIFCLOUD_ACCESS_KEY_ID` and `NIFCLOUD_SECRET_ACCESS_KEY`
3. Create an SSH key to log in to the server on the NIFCLOUD control panel.
    - The ssh key is used as instance_key_name when creating a cluster
