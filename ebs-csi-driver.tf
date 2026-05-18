data "aws_eks_addon_version" "ebs_csi_driver_addon_latest" {
  count = var.create_ebs_csi_driver ? 1 : 0

  addon_name = "aws-ebs-csi-driver"

  kubernetes_version = aws_eks_cluster.my_eks_cluster.version
  most_recent        = true
}

resource "aws_eks_addon" "my_ebs_csi_driver" {
  count = var.create_ebs_csi_driver ? 1 : 0

  cluster_name = aws_eks_cluster.my_eks_cluster.name
  addon_name   = "aws-ebs-csi-driver"

  addon_version = data.aws_eks_addon_version.ebs_csi_driver_addon_latest[count.index].version

  resolve_conflicts_on_update = "OVERWRITE"
  resolve_conflicts_on_create = "OVERWRITE"

  configuration_values = null

  tags = {
    Name = "${var.name_prefix}-ebs-csi-driver"
  }

  depends_on = [
    aws_eks_addon.my_pod_identity_agent,
    aws_eks_pod_identity_association.my_ebs_csi_driver_pod_identity_association
  ]
}
