resource "aws_eks_cluster" "my_eks_cluster" {
  name = "${var.name_prefix}-eks-cluster"

  role_arn = aws_iam_role.my_cluster_role.arn
  version  = var.eks_version

  vpc_config {
    endpoint_private_access = var.eks_endpoint_private_access
    endpoint_public_access  = var.eks_endpoint_public_access

    public_access_cidrs = var.eks_cluster_public_access_cidrs
    subnet_ids          = local.cluster_subnet_ids

  }

  kubernetes_network_config {
    service_ipv4_cidr = var.k8s_service_ipv4_cidr
  }

  enabled_cluster_log_types = var.k8s_enabled_cluster_log_types

  depends_on = [
    aws_iam_role_policy_attachment.eks_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks_AmazonEKSVPCResourceController
  ]

  tags = {
    Name = "${var.name_prefix}-eks-cluster"
  }
}

resource "aws_eks_node_group" "my_eks_nodegroup" {
  cluster_name    = aws_eks_cluster.my_eks_cluster.name
  node_group_name = "${var.name_prefix}-node-group"

  node_role_arn = aws_iam_role.my_nodegroup_role.arn
  subnet_ids    = local.cluster_subnet_ids

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable_percentage = 50
  }

  ami_type       = var.node_group_ami_type
  instance_types = var.node_group_instance_types
  capacity_type  = var.node_group_capacity_type

  disk_size = var.node_group_disk_size

  depends_on = [
    aws_iam_role_policy_attachment.eks_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks_AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.eks_AmazonSSMManagedInstanceCore
  ]
}

