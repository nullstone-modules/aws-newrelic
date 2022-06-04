output "api_key_secret_id" {
  value       = aws_secretsmanager_secret.api_key.id
  description = "string ||| The ID of the secret containing the New Relic API key"
}

output "api_key_secret_name" {
  value       = aws_secretsmanager_secret.api_key.name
  description = "string ||| The name of the secret containing the New Relic API key"
}

output "delivery_stream_arn" {
  value       = aws_kinesis_firehose_delivery_stream.newrelic.arn
  description = "string ||| The ARN of the kinesis firehose delivery stream that will forward to New Relic"
}

output "delivery_role_arn" {
  value       = aws_iam_role.log_delivery.arn
  description = "string ||| The ARN of the IAM Role that has permission to deliver logs to the kinesis firehose delivery stream"
}

output "failed_delivery_bucket_arn" {
  value       = aws_s3_bucket.failed_log_delivery.arn
  description = "string ||| The ARN of the S3 bucket where failed log delivery messages are delivered"
}

output "log_provider" {
  value       = "cloudwatch"
  description = "string ||| The provider where delivery/backup logs are stored. This is always set to 'cloudwatch'."
}

output "log_group_name" {
  value       = local.error_log_name
  description = "string ||| The name of the Cloudwatch Log Group name where delivery/backup logs are stored."
}

output "log_reader" {
  value       = local.error_log_reader
  description = "object({ name: string, access_key: string, secret_key: string }) ||| An AWS User with explicit privilege to read logs from Cloudwatch."
  sensitive   = true
}
