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
