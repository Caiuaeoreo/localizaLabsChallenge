module "tags" {
  source = "./modules/tags"
  product = var.product
  team = var.team
  environment = var.environment
  ticket = var.ticket
  application = var.application
  appid = var.appid
  coststring = var.coststring
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = "eks-${var.team}-${var.application}-${var.environment}"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = aws_subnet.subnet[*].id
  }

  tags = module.tags.tags
}

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "eks-${var.team}-${var.application}-${var.environment}-ng"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = aws_subnet.subnet[*].id

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  tags = module.tags.tags
}
