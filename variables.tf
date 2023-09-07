variable "nifcloud_access_key" {
  description = "The NIFCLOUD access key"
  type        = string
}

variable "nifcloud_secret_key" {
  description = "The NIFCLOUD secret key."
  type        = string
}

variable "acme_email_address" {
  description = "The contact email address for the account used by ACME"
  type        = string
}

variable "certificates" {
  description = "The List of certificates you want to manage"
  type = map(object({
    common_name               = string
    subject_alternative_names = list(string)
  }))
}

variable "min_days_remaining" {
  description = "The minimum amount of days remaining on the expiration of a certificate before a renewal is attempted"
  type        = number
  default     = 14
}
