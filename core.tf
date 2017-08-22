# Store this config in Terraform Enterprise
terraform {
  required_version = ">= 0.10.0"
  backend "atlas" {
    name    = "opencredo/tfenterprise-basic-push"
    address = "https://atlas.hashicorp.com"
  }
}

# Example of using a normal variable
variable "normal_value_1" {}

output "normal_value_1" {
  value     = "${var.normal_value_1}"
}

# Example of using a secret variable
variable "secret_value_1" {}

output "secret_value_1" {
  value     = "${var.secret_value_1}"
}

# Example of using a sensitive value
# We are generating arbitrary private keys. Technically they are sensitive
# but in this context, they are not used for anything, just to demo
variable "tls_private_key_count" {default = 1}

# Generate n private keys
resource "tls_private_key" "example" {
  count       = "${var.tls_private_key_count}"
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

output "tls_private_key_pem with sensitive=false" {
  sensitive = false
  value     = "${tls_private_key.example.private_key_pem}"
}

output "tls_private_key_pem with sensitive=true" {
  sensitive = true
  value     = "${tls_private_key.example.private_key_pem}"
}