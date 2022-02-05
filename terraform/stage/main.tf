terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.69.0"
    }
  }
  backend "s3" {
    key    = "terraform-states/ya-state-stage.tfstate"
  }
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

module "vpc" {
  source                   = "../modules/vpc"
  network_name             = "reddit-app-network"
  subnet_name              = "reddit-app-subnet-stage"
  v4_cidr_blocks           = ["192.168.10.0/24"]
}

module "app" {
  source                   = "../modules/app"
  vm_name                  = "reddit-stage-app"
  public_key_path          = var.public_key_path
  app_disk_image           = var.app_disk_image
  subnet_id                = module.vpc.app-subnet.id
  private_key_path         = var.private_key_path
}

module "db" {
  source                   = "../modules/db"
  vm_name                  = "reddit-stage-db"
  public_key_path          = var.public_key_path
  db_disk_image            = var.db_disk_image
  subnet_id                = module.vpc.app-subnet.id
}

module "ansiblecall" {
  source                   = "../modules/ansiblecall"
  private_key_path         = var.private_key_path
  external_ip_address_app  = module.app.external_ip_address_app
  internal_ip_address_db   = module.db.internal_ip_address_db
  proxy_port               = 80
  depends_on               = [
    module.vpc,
    module.app,
    module.db
  ]
}

/* module "reddit" {
  source                   = "../modules/reddit"
  files_dir                = "../modules/reddit/files"
  external_ip_address_app  = module.app.external_ip_address_app
  internal_ip_address_db   = module.db.internal_ip_address_db
  private_key_path         = var.private_key_path
} */
