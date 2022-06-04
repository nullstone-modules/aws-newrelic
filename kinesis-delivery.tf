locals {
  kinesis_log_destinations = tomap({
    US  = "https://aws-api.newrelic.com/firehose/v1"
    EU  = "https://aws-api.eu.newrelic.com/firehose/v1"
  })

  kinesis_metric_destinations = tomap({
    US = "https://aws-api.newrelic.com/cloudwatch-metrics/v1"
    EU = "https://aws-api.eu01.nr-data.net/cloudwatch-metrics/v1"
  })
}

resource "aws_s3_bucket" "failed_log_delivery" {
  bucket        = "${local.resource_name}-failed-log-delivery"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "failed_log_delivery" {
  bucket = aws_s3_bucket.failed_log_delivery.id
  acl    = "private"
}

resource "aws_iam_role" "log_delivery" {
  name               = "${local.resource_name}-log-delivery"
  assume_role_policy = data.aws_iam_policy_document.log_delivery_assume.json
}

data "aws_iam_policy_document" "log_delivery_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["firehose.amazonaws.com"]
    }
  }
}

resource "aws_kinesis_firehose_delivery_stream" "newrelic" {
  name        = local.resource_name
  tags        = local.tags
  destination = "http_endpoint"

  s3_configuration {
    bucket_arn         = aws_s3_bucket.failed_log_delivery.arn
    role_arn           = aws_iam_role.log_delivery.arn
    buffer_size        = 1
    buffer_interval    = 60
    compression_format = "GZIP"
  }

  http_endpoint_configuration {
    url                = local.kinesis_log_destinations[var.region]
    name               = "New Relic"
    access_key         = var.api_key
    buffering_size     = 1
    buffering_interval = 60
    retry_duration     = 60
    role_arn           = aws_iam_role.log_delivery.arn
    s3_backup_mode     = "FailedDataOnly"

    request_configuration {
      content_encoding = "GZIP"

      common_attributes {
        name  = "stack"
        value = local.stack_name
      }

      common_attributes {
        name  = "env"
        value = local.env_name
      }
    }
  }
}