data "aws_availability_zones" "azs" {
  state = "available"
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

module "cluster_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.cluster_name
  cidr = var.cluster_vpc_cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  azs             = slice(data.aws_availability_zones.azs.names, 0, 3)
  private_subnets = var.cluster_private_subnets
  public_subnets  = var.cluster_public_subnets

  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true

}

module "cluster" {
  source  = "terraform-redhat/rosa-classic/rhcs"
  version = "1.6.5"

  cluster_name               = var.cluster_name
  openshift_version          = var.openshift_version
  create_account_roles       = true
  create_operator_roles      = true
  create_oidc                = true
  create_admin_user          = true
  account_role_prefix        = var.cluster_name
  autoscaling_enabled        = true
  aws_subnet_ids             = module.aws.cluster_private_subnets
  cluster_autoscaler_enabled = true
  compute_machine_type       = var.default_instance_type
  machine_cidr               = module.aws.cluster_vpc_cidr_block
  managed_oidc               = true
  min_replicas               = 3
  max_replicas               = 15
  multi_az                   = true
  aws_availability_zones     = slice(data.aws_availability_zones.azs.names, 0, 3)
  aws_private_link           = true
  private                    = true
  operator_role_prefix       = var.cluster_name
  pod_cidr                   = var.pod_cidr
  wait_for_create_complete   = true

  depends_on = [ module.cluster_vpc ]
}
