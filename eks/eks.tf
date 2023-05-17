## /AWS EKS
resource "aws_eks_cluster" "eks-cluster" {
  name                      = var.cluster_name
  version                   = var.cluster_version
  role_arn                  = aws_iam_role.iam-role-eks.arn
  enabled_cluster_log_types = ["api", "audit"]

  vpc_config {
    subnet_ids              = ["subnet-0787e6abb69cb6904", "subnet-0e9b35e74abba5c66", "subnet-0eaa3bb987c57dc67"]
    security_group_ids      = ["sg-05f2598600e4f5c85"]
    endpoint_private_access = true
  }

  depends_on = [
    aws_iam_role.iam-role-eks,
    aws_cloudwatch_log_group.eks-cloudwatch-log-group-eks-cluster,
    #aws_security_group.eks-cluster,
  ]
}

resource "aws_cloudwatch_log_group" "eks-cloudwatch-log-group-eks-cluster" {
  name              = "/aws/eks/eks-cluster/cluster"
  retention_in_days = 90
}

data "external" "thumbprint" {
  program = ["./thumbprint.sh", var.region]
}

resource "aws_iam_openid_connect_provider" "eks-iam-openid-eks-cluster" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.external.thumbprint.result.thumbprint]
  url             = aws_eks_cluster.eks-cluster.identity[0].oidc[0].issuer
}

data "aws_caller_identity" "current" {
}


data "aws_iam_policy_document" "eks-eks-cluster-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test = "StringEquals"
      variable = "${replace(
        aws_iam_openid_connect_provider.eks-iam-openid-eks-cluster.url,
        "https://",
        "",
      )}:sub"
      values = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks-iam-openid-eks-cluster.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "eks-iam-role-eks-cluster" {
  assume_role_policy = data.aws_iam_policy_document.eks-eks-cluster-assume-role-policy.json
  name               = "eks-iam-role-eks-cluster"
}