module "logs" {
  source = "nullstone-modules/logs/aws"

  name              = local.resource_name
  tags              = local.tags
  enable_log_reader = true
  retention_in_days = 90
}

locals {
  error_log_name  = module.logs.name
  error_log_reader = module.logs.reader
}
