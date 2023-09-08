terraform {
  required_version = "1.5.6"
  required_providers {
    nifcloud = {
      source  = "nifcloud/nifcloud"
      version = "1.10.1"
    }
    acme = {
      source  = "vancluever/acme"
      version = "2.14.0"
    }
  }
}

locals {
  nifcloud_access_key = "YOUR_ACCESS_KEY"
  nifcloud_secret_key = "YOUR_SECRET_KEY"

  acme_email_address = "XXXXXX@YYYY.com"
  # see: https://letsencrypt.org/docs/acme-protocol-updates/#acme-v2-rfc-8555
  server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"

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
