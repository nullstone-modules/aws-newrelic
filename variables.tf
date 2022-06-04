variable "region" {
  type        = string
  default     = "US"
  description = <<EOF
The region for the data center holding your data in New Relic.
Valid values are `US` or `EU`.
EOF

  validation {
    condition     = var.region == "US" || var.region == "EU"
    error_message = "The New Relic region must be US or EU."
  }
}

variable "api_key" {
  description = "API Key to emit logs/metrics to New Relic. The value is usually prefixed with `NRAK`."
  type        = string
  sensitive   = true
}

variable "account_id" {
  description = "Your New Relic Account ID."
  type        = string
  sensitive   = true
}
