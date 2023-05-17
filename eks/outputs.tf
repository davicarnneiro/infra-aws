# aws
output "region" {
  description = "AWS region"
  value       = var.region
}

output "AZs" {
  value = "${data.aws_availability_zones.available.names[3]}, ${data.aws_availability_zones.available.names[2]}, ${data.aws_availability_zones.available.names[1]}"
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

# cluster name
output "cluster_name" {
  value = var.cluster_name
}

output "cluster_version" {
  value = var.cluster_version
}

# spotinst
output "spotinst_account" {
  value = var.spotinst_account
}