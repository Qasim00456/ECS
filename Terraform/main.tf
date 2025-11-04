module "vpc" {
  source = "./modules/vpc"
  
  # We'll replace with real variables later
}

module "iam" {
  source = "./modules/iam"

}


module "alb" {
    source = "./modules/alb"
vpc_id = module.vpc.vpc_id
sg_id = module.vpc.alb_sg_id
subnet_ids = module.vpc.public_subnet_ids
}

module "ecs" {
  
  source = "./modules/ecs"
  subnet_ids = module.vpc.subnet_ids
  sg_id =  module.vpc.sg_id
  target_group_arn = module.alb.target_group_arn
  alb_id = module.alb.alb_id
  execution_role_arn = module.iam.execution_role_arn

}

module "route53" {
  source = "./modules/Route53"
  dns_name = module.alb.dns_name
}