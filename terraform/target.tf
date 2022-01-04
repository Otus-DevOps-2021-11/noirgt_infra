resource "yandex_lb_target_group" "reddit_target_group" {
  name      = "reddit-target-group"
  region_id = var.region

  dynamic "target" {
    for_each = [
      for one_app in yandex_compute_instance.app : {
      subnet_id = one_app.network_interface.0.subnet_id
      address   = one_app.network_interface.0.ip_address
      }]

    content {
      subnet_id = target.value.subnet_id
      address   = target.value.address
    }
  }
}