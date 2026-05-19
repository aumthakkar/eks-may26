variable "aws_region" {}
variable "name_prefix" {}
variable "vpc_cidr" {}

variable "public_subnets_count" {}
variable "private_subnets_count" {}

variable "auto_create_public_subnets" {}
variable "auto_create_private_subnets" {}

variable "public_cidr_block" {}
variable "private_cidr_block" {}

# EKS Cluster Variables
variable "eks_version" {}

variable "eks_endpoint_private_access" {}
variable "eks_endpoint_public_access" {}

variable "eks_cluster_public_access_cidrs" {}

variable "k8s_service_ipv4_cidr" {}
variable "k8s_enabled_cluster_log_types" {}

# EKS Node_group variables
variable "node_group_ami_type" {}
variable "node_group_instance_types" {}

variable "node_group_capacity_type" {}
variable "node_group_disk_size" {}

variable "create_ebs_csi_driver" {}
variable "create_cw_obs_driver" {}
variable "create_lb_controller_driver" {}
variable "create_efs_csi_driver" {}