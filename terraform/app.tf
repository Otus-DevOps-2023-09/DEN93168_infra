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
	subnet_id = yandex_vpc_subnet.app-subnet.id
	nat = true
  }

metadata = {
  ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  connection {
  type = "ssh"
  host = yandex_compute_instance.app.network_interface.0.nat_ip_address
  user = "ubuntu"
  agent = false
  # путь до приватного ключа
  private_key = file(var.private_key_path)
  }
  
#  provisioner "file" {
#  source = "files/puma.service"
#  destination = "/tmp/puma.service"
#}

#  provisioner "remote-exec" {
#  script = "files/deploy.sh"
#}

}

