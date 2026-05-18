resource "aws_iam_role" "my_lb_controller_driver_role" {
  count = var.create_lb_controller_driver ? 1 : 0

  name = "${var.name_prefix}-lb-controller-iam-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Sid    = "LoadBalancerControllerDriver"
        Principal = {
          Service = "pods.eks.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "${var.name_prefix}-lb-controller-iam-role"
  }
}

resource "aws_iam_role_policy_attachment" "eks_AmazonEKSLoadBalancingPolicy" {
  count = var.create_lb_controller_driver ? 1 : 0

  role       = aws_iam_role.my_lb_controller_driver_role[count.index].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSLoadBalancingPolicy"
}

resource "aws_eks_pod_identity_association" "my_lb_controller_driver_pod_identity_association" {
  count = var.create_lb_controller_driver ? 1 : 0

  cluster_name = aws_eks_cluster.my_eks_cluster.name
  namespace    = "kube-system"

  service_account = "aws-load-balancer-controller"
  role_arn        = aws_iam_role.my_lb_controller_driver_role[count.index].arn
}