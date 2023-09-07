terraform {
  required_version = ">=1.5.6"

  required_providers {
    nifcloud = {
      source  = "nifcloud/nifcloud"
      version = ">=1.10.1"
    }
    acme = {
      source = "vancluever/acme"
      # If a higher version is used, the following error would occur.
      # [failed to change record set: Sender(MalformedXML): The request xml is malformed]
      version = "2.14.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">=4.0.4"
    }
  }
}
