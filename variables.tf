variable "cluster_name" {
  type = string
}

variable "cluster_vpc_cidr" {
  type = string
}

variable "cluster_private_subnets" {
  type = list(string)
}

variable "cluster_public_subnets" {
  type = list(string)
}

variable "openshift_version" {
  type = string
}

variable "default_instance_type" {
  type = string
}

variable "pod_cidr" {
  type = string
  default = "192.168.0.0/16"
}

variable "aws_account_access_key" {
  type = string
}

variable "aws_account_secret_key" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "ocm_token" {
  type = string
  sensitive = true
}

variable "ocm_url" {
  type = string
  default = "https://api.openshift.com"
}
