terraform {
  backend "s3" {
    region = "eu-north-1"
    key    = "eks-cluster/terraform.tfstate"
    bucket = "pht-dev-eks-cluster-state"
  }

}