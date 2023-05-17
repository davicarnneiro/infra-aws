### /VPC
module "vpc" {
  source                 = "terraform-aws-modules/vpc/aws"
  version                = "4.0.1"
  name                   = var.ocean_cluster_name
  cidr                   = "172.43.0.0/16"
  azs                    = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets        = ["172.43.4.0/22", "172.43.8.0/22", "172.43.12.0/22"]
  public_subnets         = ["172.43.16.0/22", "172.43.20.0/22", "172.43.24.0/22"]
  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true
  enable_dns_hostnames   = true
  tags = {
    "kubernetes.io/cluster/${var.ocean_cluster_name}" = "shared"
    "kubernetes.io/role/elb"                          = "1"
  }
}

### /SG
resource "aws_security_group" "all_worker_mgmt" {
  name_prefix = "all_worker_management"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["172.0.0.0/8"]
  }
  depends_on = [module.vpc]
}