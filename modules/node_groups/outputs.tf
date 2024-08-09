output "node_groups" {
  description = "Outputs from EKS node groups. Map of maps, keyed by `var.node_groups` keys. See `aws_eks_node_group` Terraform documentation for values"
  value       = aws_eks_node_group.node_groups
}

output "aws_auth_roles" {
  description = "Roles for use in aws-auth ConfigMap"
  value = [
    for k, v in local.node_groups_expanded : {
      instance_role_arn = lookup(v, "iam_role_arn", aws_iam_role.node_groups[0].arn)
      platform          = "linux"
    }
  ]
}
