terraform {
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

