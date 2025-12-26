module "eks" {
    #import the module template
    source = "terraform-aws-modules/eks/aws"
    version = "~> 21.0"

    #control-plane cluster information
    name = local.name
    kubernetes_version = "1.33"

    addons = {
    coredns                = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy             = {}
    vpc-cni                = {
      before_compute = true
    }
  }

    endpoint_public_access = true

    #vpc for node groups
    vpc_id = module.vpc.vpc_id
    subnet_ids = module.vpc.private_subnets

    #vpc for control plane
    control_plane_subnet_ids = module.vpc.intra_subnets

    #managing nodes in the cluster
   eks_managed_node_groups = {
    example = {
      instance_types = ["t3.medium"]

      min_size     = 2
      max_size     = 3
      desired_size = 2

      capacity_type = "SPOT"
    }
  }

    tags = {
        Environment = local.env
        Terraform = true
    }
}