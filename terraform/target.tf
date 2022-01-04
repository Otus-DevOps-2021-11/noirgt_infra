resource "yandex_lb_target_group" "reddit_target" {
  name      = "reddit-target-group"
  region_id = var.region

  target {
    subnet_id = var.subnet_id
    address   = yandex_compute_instance.app.network_interface.0.ip_address
  }

  target {
    subnet_id = var.subnet_id
    address   = yandex_compute_instance.app2.network_interface.0.ip_address
  }

}