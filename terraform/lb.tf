resource "yandex_lb_network_load_balancer" "lb" {
  name = "reddit-load-balancer"

  listener {
    name = "reddit-listener"
    port = 9292
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.reddit_target_group.id

    healthcheck {
      name = "http"
      http_options {
        port = 9292
        path = "/"
      }
    }
  }
}