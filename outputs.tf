output "certificates" {
  value = { for k, v in nifcloud_ssl_certificate.this : k => {
    fqdn_id = v.fqdn_id
    fqdn    = v.fqdn
    }
  }
}
