module "logs" {
  source = "nullstone-modules/logs/aws"

  name              = local.resource_name
  tags              = local.tags
  enable_log_reader = true
  retention_in_days = 90
}

resource "aws_cloudwatch_log_stream" "error_destination" {
  log_group_name = local.error_log_name
  name           = "DestinationDelivery"
}

locals {
  error_log_name   = module.logs.name
  error_log_reader = module.logs.reader
  error_log_stream = aws_cloudwatch_log_stream.error_destination.name
}
