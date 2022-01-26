provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

module "vpc" {
  source = "../modules/vpc"
}

module "app" {
  source           = "../modules/app"
  public_key_path  = var.public_key_path
  app_disk_image   = var.app_disk_image
  subnet_id        = module.vpc.app-subnet.id
  private_key_path = var.private_key_path
}

module "db" {
  source          = "../modules/db"
  public_key_path = var.public_key_path
  db_disk_image   = var.db_disk_image
  subnet_id       = module.vpc.app-subnet.id
}

/* module "reddit" {
  source                  = "../modules/reddit"
  files_dir               = "../modules/reddit/files"
  external_ip_address_app = module.app.external_ip_address_app
  internal_ip_address_db  = module.db.internal_ip_address_db
  private_key_path        = var.private_key_path
} */