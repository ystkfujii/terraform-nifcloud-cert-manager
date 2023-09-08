resource "tls_private_key" "this" {
  algorithm = "RSA"
}

resource "acme_registration" "this" {
  account_key_pem = tls_private_key.this.private_key_pem
  email_address   = var.acme_email_address
}

resource "acme_certificate" "this" {
  for_each = var.certificates

  account_key_pem           = acme_registration.this.account_key_pem
  common_name               = each.value.common_name
  subject_alternative_names = each.value.subject_alternative_names

  min_days_remaining = var.min_days_remaining

  dns_challenge {
    provider = "nifcloud"
    config = {
      access_key = var.nifcloud_access_key
      secret_key = var.nifcloud_secret_key
    }
  }
}

resource "nifcloud_ssl_certificate" "this" {
  for_each = var.certificates

  certificate = acme_certificate.this[each.key].certificate_pem
  key         = acme_certificate.this[each.key].private_key_pem
  ca          = acme_certificate.this[each.key].issuer_pem
  description = each.key

  lifecycle {
    create_before_destroy = true
  }
}
