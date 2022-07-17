module "networking" {
  source     = "./modules/networking"
  gcp_region = var.gcp_region
}
module "database" {
  source              = "./modules/database"
  main-vpc-id         = module.networking.main-vpc-id
  main-vpc-connection = module.networking.main-vpc-connection
  gcp_region          = var.gcp_region
  db_user_name        = var.db_user_name
  db_user_password    = var.db_user_password
}
