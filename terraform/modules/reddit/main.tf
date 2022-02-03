terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.69.0"
    }
  }
}

resource "null_resource" "reddit_deploy" {
  connection {
    type        = "ssh"
    host        = var.external_ip_address_app
    user        = "ubuntu"
    agent       = false
    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }

  provisioner "file" {
    source      = "${var.files_dir}/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "${var.files_dir}/deploy.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sed -i 's/127.0.0.1:27017/${var.internal_ip_address_db}:27017/g' /home/ubuntu/reddit/app.rb",
      "sudo systemctl restart puma.service"
    ]
  }
}
