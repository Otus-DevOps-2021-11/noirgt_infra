terraform {
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "noirgt-infra-bucket"
    region     = "ru-central1"
    key        = "terraform-states/ya-state.tfstate"
    access_key = var.s3_access_key
    secret_key = var.s3_secret_key

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}