# login
#### spotinst 
variable "spotinst_token" {
  description = "The Spotinst token used by the controller."
  default     = "43aa853919a348b88ee30b335ab1c78cf06b7e5758acd824243d738ae5283a2f"
}

variable "spotinst_account" {
  description = "The Spotinst account ID used by the controller."
  default     = "act-69a04d18"
}

variable "region" {
  description = "Aws Region"
  default     = "us-east-1"
}

variable "env" {
  description = "Environment"
  default = "dev"
  
}

variable "nginx_controller_chart_version" {
  type        = string
  default     = "4.5.2"
  description = "Nginx ingress controller chart version"
}

variable "ami" {
  description = "An AMI that is compatible with your desired version of kubernetes."
  default     = "ami-0f114867066b78822"
}

variable "cluster_version" {
  description = "Kubernetes supported version."
  default     = "1.26"
}

variable "cluster_name" {
  description = "EKS name"
  default     = "eks-cluster"
}

variable "min_size" {
  description = "The lower limit of instances the cluster can scale down to."
  default     = "3"
}

variable "max_size" {
  description = "The upper limit of instances the cluster can scale up to."
  default     = "3"
}

variable "desired_capacity" {
  description = "The number of instances to launch and maintain in the cluster."
  default     = "3"
}

variable "key_name" {
  description = "The key pair to attach the instances."
  default     = "chave.pem"
}

variable "tags" {
  type = map(string)
  default = {
    "stefanini/config.ref"                = "dev.iac.terraform.eks-cluster"
    "stefanini/deploy"                    = "terraform"
    "stefanini/env"                       = "develop"
    "stefanini/cluster.name"              = "eks-cluster"
    "stefanini/metrics.coletor"           = "prometheus"
    "stefanini/observability.ui"          = "spot"
    "stefanini/public.cloud"              = "Aws"
    "stefanini/kubernetes"                = "managed"
    "stefanini/kubernetes.implementation" = "eks"
  }
}

variable "labels" {
  type = map(string)
  default = {
    "stefanini/config.ref"                = "dev.iac.terraform.eks-cluster"
    "stefanini/deploy"                    = "terraform"
    "stefanini/env"                       = "develop"
    "stefanini/cluster.name"              = "eks-cluster"
    "stefanini/metrics.coletor"           = "prometheus"
    "stefanini/observability.ui"          = "spot"
    "stefanin/spot.account"               = "act-69a04d18"
    "stefanini/public.cloud"              = "Aws"
    "stefanini/kubernetes"                = "managed"
    "stefanini/kubernetes.implementation" = "eks"
  }
}
