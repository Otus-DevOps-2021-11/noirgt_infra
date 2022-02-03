terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.69.0"
    }
  }
}

resource "null_resource" "check_ssh_availability" {
    connection {
    type        = "ssh"
    host        = var.external_ip_address_app
    user        = "ubuntu"
    agent       = false
    private_key = file(var.private_key_path)
    }
  provisioner "remote-exec" {
    inline = [
      "echo HELLO"
    ]
  }
}

resource "null_resource" "ansible_deploy" {
    triggers = {
      proxy_port     = "${var.proxy_port}"
    }

    provisioner "local-exec" {
      command = "cd $ansible_path && ansible-playbook -i $invetory $playbook --extra-vars \"db_host=$db_internal_ip proxy_port=$proxy_port\""
      environment = {
          ansible_path   = "../../ansible"
          invetory       = "environments/stage/inventory.py"
          playbook       = "playbooks/site.yml"
          db_internal_ip = "${var.internal_ip_address_db}"
          proxy_port     = "${var.proxy_port}"
      }
    }
    depends_on = [
      null_resource.check_ssh_availability
    ]
}
