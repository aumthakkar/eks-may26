resource "helm_release" "my_lb_controller_driver" {
  name       = "${var.name_prefix}-lb-controller-driver"
  namespace = "kube-system"

  repository = "https://aws.github.io/eks-charts"
  chart   = "aws-load-balancer-controller"
  version = "3.3.0"


  set = [
    {
      name  = "replicaCount"
      value = 1
    },
    {
      name  = "image.repository"
      value = "602401143452.dkr.ecr.eu-north-1.amazonaws.com/amazon/aws-load-balancer-controller"
    },
    {
      name  = "image.tag"
      value = "v3.3.0"
    },
    {
      name  = "serviceAccount.create"
      value = true
    },
    {
      name  = "serviceAccount.name"
      value = "aws-load-balancer-controller"
    },
    {
      name  = "clusterName"
      value = aws_eks_cluster.my_eks_cluster.name
    },
    {
      name  = "vpcId"
      value = aws_vpc.my_vpc.id
    },
    {
      name  = "region"
      value = var.aws_region
    }
  ]
  depends_on = [
    aws_eks_addon.my_pod_identity_agent,
    aws_eks_pod_identity_association.my_lb_controller_driver_pod_identity_association
  ]
}