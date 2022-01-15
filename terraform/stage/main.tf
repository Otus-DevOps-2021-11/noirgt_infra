terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.69.0"
    }
  }

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "noirgt-infra-bucket"
    region     = "ru-central1"
    key        = "terraform-states/ya-state.tfstate"
    access_key = "vDW86CC49K_Hp4N4t1Rj"
    secret_key = "PeQeTws-NfE6A3-YS8RVpJTtrzqM5DJsTONR_kaf"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

module "app" {
  source          = "../modules/app"
  public_key_path = var.public_key_path
  app_disk_image  = var.app_disk_image
  subnet_id       = var.subnet_id
  private_key_path = var.private_key_path
}

module "db" {
  source          = "../modules/db"
  public_key_path = var.public_key_path
  db_disk_image   = var.db_disk_image
  subnet_id       = var.subnet_id
}

module "reddit" {
  source                  = "../modules/reddit"
  files_dir               = "../modules/reddit/files"
  external_ip_address_app = module.app.external_ip_address_app
  internal_ip_address_db  = module.db.internal_ip_address_db
  private_key_path        = var.private_key_path
}