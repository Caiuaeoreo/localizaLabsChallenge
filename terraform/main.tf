module "tags" {
  source      = "./modules/tags"
  product     = var.product
  team        = var.team
  environment = var.environment
  ticket      = var.ticket
  application = var.application
  appid       = var.appid
  coststring  = var.coststring
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_subnet" "public_a" {
  vpc_id                    = aws_vpc.main.id
  cidr_block                = var.subnet_cidr_a
  availability_zone         = var.availability_zone_a
  map_public_ip_on_launch   = true
}

resource "aws_subnet" "public_b" {
  vpc_id                    = aws_vpc.main.id
  cidr_block                = var.subnet_cidr_b
  availability_zone         = var.availability_zone_b
  map_public_ip_on_launch   = true
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.main.id
}

# EKS IAM Role
resource "aws_iam_role" "eks_role" {
  name               = "eks-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role_policy.json

  tags = module.tags.tags
}

data "aws_iam_policy_document" "eks_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "eks_role_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_role.name
}

resource "aws_iam_role_policy_attachment" "eks_role_AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_role.name
}

# EKS Node Group IAM Role
resource "aws_iam_role" "eks_node_role" {
  name               = "eks-node-group-role"
  assume_role_policy = data.aws_iam_policy_document.eks_node_assume_role_policy.json

  tags = module.tags.tags
}

data "aws_iam_policy_document" "eks_node_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "eks_node_role_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "eks_node_role_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "eks_node_role_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_role.name
}

# Security Group for EKS Cluster
resource "aws_security_group" "eks_cluster_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = module.tags.tags
}

# EKS Cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.application
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids         = [aws_subnet.public_a.id, aws_subnet.public_b.id]
    security_group_ids = [aws_security_group.eks_cluster_sg.id]
  }

  tags = module.tags.tags
}

# EKS Node Group
resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "eks-${var.application}-ng"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = [aws_subnet.public_a.id, aws_subnet.public_b.id]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  tags = module.tags.tags
}

# ECR Repository
resource "aws_ecr_repository" "myapp-repo" {
  name = "${var.application}-${var.environment}"

  image_tag_mutability = "MUTABLE"

  tags = module.tags.tags
}