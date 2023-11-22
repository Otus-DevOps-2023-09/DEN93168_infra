terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.89.0"
    }
  }
}

provider "yandex" {
#  token = "y0_AgAAAAAWejyQAATuwQAAAADk_g5kVSxJNM-1Ttqui1ssPSNIkVtIdRg"
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

resource "yandex_compute_instance" "app" {
  name = "reddit-app"
  labels = {
    tags = "reddit-app"
  }

  resources {
    cores  = 2
    memory = 4
    core_fraction = 20
  }
  
    boot_disk {
    initialize_params {
      image_id = var.app_disk_image
    }
  }
  
  network_interface {
	subnet_id = var.subnet_id
	nat = true
  }

metadata = {
  ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

#  connection {
#  type = "ssh"
#  host = yandex_compute_instance.app.network_interface.0.nat_ip_address
#  user = "ubuntu"
#  agent = false
  # путь до приватного ключа
#  private_key = file(var.private_key_path)
#  }
  
#  provisioner "file" {
#  source = "files/puma.service"
#  destination = "/tmp/puma.service"
#}

#  provisioner "remote-exec" {
#  script = "files/deploy.sh"
#}

}

