module "networking" {
  source = "./modules/networking"
}

module "instances" {
  source         = "./modules/instances"
  private-subnet = module.networking.private-subnet
  public-subnet  = module.networking.public-subnet
}

module "database" {
  source              = "./modules/database"
  main-vpc-id         = module.networking.main-vpc-id
  main-vpc-connection = module.networking.main-vpc-connection
}
