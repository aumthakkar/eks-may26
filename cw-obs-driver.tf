data "aws_eks_addon_version" "my_cw_obs_driver_addon_latest" {
  count = var.create_cw_obs_driver ? 1 : 0

  addon_name = "amazon-cloudwatch-observability"

  kubernetes_version = aws_eks_cluster.my_eks_cluster.version
  most_recent        = true
}

resource "aws_eks_addon" "my_cw_obs_driver" {
  count = var.create_cw_obs_driver ? 1 : 0

  cluster_name = aws_eks_cluster.my_eks_cluster.name
  addon_name   = "amazon-cloudwatch-observability"

  addon_version = data.aws_eks_addon_version.my_cw_obs_driver_addon_latest[count.index].version

  resolve_conflicts_on_update = "OVERWRITE"
  resolve_conflicts_on_create = "OVERWRITE"

  configuration_values = null

  tags = {
    Name = "${var.name_prefix}-cw-obs-driver"
  }

  depends_on = [
    aws_eks_addon.my_pod_identity_agent,
    aws_eks_pod_identity_association.my_cw_obs_pod_identity_association
  ]
}
