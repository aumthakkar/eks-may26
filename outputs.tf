output "cluster_name" {
  value = aws_eks_cluster.my_eks_cluster.id
}

output "cluster_endpoint" {
  value = aws_eks_cluster.my_eks_cluster.endpoint
}

output "cluster_ca_certificate" {
  value = aws_eks_cluster.my_eks_cluster.certificate_authority[0].data
}
