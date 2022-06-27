resource "google_sql_database_instance" "sql-instance" {
  name             = "sql-instance-1"
  region           = var.db_region
  database_version = var.database_version
  deletion_protection = false

  depends_on = [var.main-vpc-connection]

  settings {
    tier = var.tier
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.main-vpc-id
    }
  }
}

# Create User
resource "google_sql_user" "admin" {
    count = 1 
    name = "${var.user_name}"
    host = "${var.user_host}"
    password = "${var.user_password}"
    instance = "${google_sql_database_instance.sql-instance.name}"
}
