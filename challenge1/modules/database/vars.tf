# Cloud SQL config fields
variable "tier" { default = "db-f1-micro" }
variable "name" { default = "gcpdatabase" }
variable "db_region" { default = "europe-west2" }
variable "disk_size" { default = "20" }
variable "database_version" { default = "MYSQL_5_7" }

# Cloud SQL user params. In production env, this will be maintained in secrets
variable "user_host" { default = "%" }
variable "user_name" { default = "admin" }
variable "user_password" { default = "123456" }

# Private VPC connection with a GCP service provider
variable "main-vpc-connection" {
  description = "Private vpc connnection"
}

# Custom VPC "main" id
variable "main-vpc-id" {
  type = string
  description = "Private vpc id"
}
