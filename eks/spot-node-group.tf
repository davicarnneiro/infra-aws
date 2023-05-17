## /AWS EKS NODE GROUP
resource "spotinst_elastigroup_aws" "spotinst-eks-cluster" {
  name                          = "Spotinst::Ocean::eks-cluster"
  orientation                   = "balanced"
  draining_timeout              = 120
  utilize_reserved_instances    = true
  fallback_to_ondemand          = true
  region                        = var.region
  desired_capacity              = var.desired_capacity
  min_size                      = var.min_size
  max_size                      = var.max_size
  capacity_unit                 = "instance"
  instance_types_ondemand       = "c5.xlarge"
  instance_types_spot           = ["c4.xlarge", "c5.xlarge", "r4.xlarge", "r5.xlarge", "m4.xlarge", "t3.xlarge", "t3.2xlarge", "t3a.2xlarge", "t3a.xlarge"]
  instance_types_preferred_spot = ["m4.xlarge", "c4.xlarge", "r4.xlarge", "c5.xlarge", "t3.xlarge"]
  subnet_ids                    = ["subnet-0787e6abb69cb6904", "subnet-0e9b35e74abba5c66", "subnet-0eaa3bb987c57dc67"]
  product                       = "Linux/UNIX"
  security_groups               = ["sg-05f2598600e4f5c85", "sg-059bab8ce8e61c418"]
  enable_monitoring             = false
  ebs_optimized                 = true
  spot_percentage               = 90
  image_id                      = var.ami
  key_name                      = var.key_name
  iam_instance_profile          = aws_iam_instance_profile.workers.name
  health_check_type             = "K8S_NODE"
  health_check_grace_period     = 300
  placement_tenancy             = "default"
  preferred_availability_zones  = ["us-east-1c", "us-east-1b", "us-east-1a"]
  user_data                     = "IyEvYmluL2Jhc2gKc2V0IC1vIHh0cmFjZQovZXRjL2Vrcy9ib290c3RyYXAuc2ggZWtzLWhvbmRhLWNhcnJvLWNvbmVjdGFkbyAtLWt1YmVsZXQtZXh0cmEtYXJncyAtLW5vZGUtbGFiZWxzPW5vZGUuZ3JvdXA9ZWtzLWhvbmRhLWNhcnJvLWNvbmVjdGFkby1ub2RlZ3JvdXAsc3BvdD10cnVl"

ebs_block_device {
    device_name           = "/dev/xvda"
    delete_on_termination = true
    encrypted             = false
    volume_size           = 30
    volume_type           = "GP3"
  }

  integration_kubernetes {
    integration_mode         = "pod"
    cluster_identifier       = aws_eks_cluster.eks-cluster.name
    autoscale_is_enabled     = true
    autoscale_is_auto_config = true
    autoscale_cooldown       = 300

    autoscale_down {
      evaluation_periods = 300
    }

    autoscale_labels {
      key   = "node.group"
      value = "cluster-nodegroup"
    }
  }

  depends_on = [
    aws_eks_cluster.eks-cluster,
  
  ]

  tags {
    key   = "Name"
    value = "cluster-nodegroup"
  }
  tags {
    key   = "kubernetes.io/cluster/eks-cluster"
    value = "owned"
  }
  tags {
    key = "k8s.io/cluster-autoscaler/enabled"

    value = "true"
  }
  tags {
    key   = "mantainer"
    value = "DevOps"
  }
  tags {
    key   = "Environment"
    value = "DEV"
  }
}