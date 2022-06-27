variable "tier" { default = "db-f1-micro" }
variable "name" { default = "gcpdatabase" }
variable "db_region" { default = "europe-west2" }
variable "disk_size" { default = "20" }
variable "database_version" { default = "MYSQL_5_7" }
variable "user_host" { default = "%" }
variable "user_name" { default = "admin" }
variable "user_password" { default = "123456" }
variable "activation_policy" { default = "always" }

variable "main-vpc-connection" {
  description = "Private vpc connnection"
}

variable "main-vpc-id" {
  type = string
  description = "Private vpc id"
}

# variable "db-subnet-1" {
#   type = string
#   description = "Db Private subnet name"
# }
