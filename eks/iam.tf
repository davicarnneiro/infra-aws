# IAM
resource "aws_iam_instance_profile" "workers" {
  name_prefix = var.cluster_name
  role        = aws_iam_role.iam-node-role-eks.name
}


data "aws_iam_policy_document" "eks-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ec2-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "iam-role-eks" {
  name               = "iam-role-eks"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.eks-assume-role-policy.json
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.iam-role-eks.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.iam-role-eks.name
}

resource "aws_iam_role" "iam-node-role-eks" {
  name               = "iam-node-role-eks"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ec2-assume-role-policy.json
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.iam-node-role-eks.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.iam-node-role-eks.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.iam-node-role-eks.name
}

resource "aws_iam_role_policy_attachment" "CloudWatchReadOnlyAccess" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"
  role       = aws_iam_role.iam-node-role-eks.name
}
